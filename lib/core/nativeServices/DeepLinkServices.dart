import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import '../constants/RoutesName.dart';
import '../utils/Logger.dart';

const MOVIE_KEY = "movieId";
const MOVIE_IMAGE_URL = "imageUrl";
const TICKETRESERVATION = "reservationId";

class DeepLinkServices {
  BuildContext context;
  GlobalKey<NavigatorState> navigatorKey;
  DeepLinkServices(this.context, this.navigatorKey);

  StreamSubscription<Map>? _streamSubscription;

  Future<void> initDeepLinksService() async {
    _streamSubscription = FlutterBranchSdk.listSession().listen((event) {
      if (event.containsKey("+clicked_branch_link") && event["+clicked_branch_link"] == true) {
        handleDeepLink(event);
      }
    }, onError: (error , stack) {
      Logger.customLogError("DeepLinkServices", error, stack);
    });
  }

  void handleDeepLink(Map<dynamic, dynamic> data) {

    if (data.containsKey(MOVIE_KEY) && data[MOVIE_KEY] != null) {
      navigatorKey.currentState?.pushNamed(RoutesName.movieDetailScreen,arguments: {
        MOVIE_KEY: data[MOVIE_KEY],
        MOVIE_IMAGE_URL : data[MOVIE_IMAGE_URL],
        'isDeepLinking' :true
      });
    }
    else if (data.containsKey(TICKETRESERVATION) && data[TICKETRESERVATION] != null) {
      navigatorKey.currentState?.pushNamed(RoutesName.ticketListScreen,arguments: {
        TICKETRESERVATION: data[TICKETRESERVATION],
        'isDeepLinking' : true
      });
    }
    else {
      navigatorKey.currentState?.pushNamed(RoutesName.mainSection);
    }
  }


  static void shareDeepLink( {required String title,required String discription,required BranchContentMetaData data})async {

    BranchUniversalObject buo = BranchUniversalObject(
      canonicalIdentifier: 'flutter/branch',
      title: title ,
      contentDescription: discription,
      publiclyIndex: true,
      locallyIndex: true,
      contentMetadata:data
    );

    BranchLinkProperties lp = BranchLinkProperties(
        channel: 'facebook',
        feature: 'sharing',
        stage: 'new share',
    );
    BranchResponse response = await FlutterBranchSdk.showShareSheet(
        buo: buo,
        linkProperties: lp,
        messageText: discription,
        androidMessageTitle: title,
        androidSharingTitle: title
    );

    if (response.success) {
      print('showShareSheet Sucess ${response.result}');
    } else {
      print('Error : ${response.errorCode} - ${response.errorMessage}');
    }
  }


}


// GestureDetector(
// onTap: () async {
//
// BranchUniversalObject buo = BranchUniversalObject(
// canonicalIdentifier: 'flutter/branch',
// //canonicalUrl: '',
// title: 'movieId title',
// contentDescription: 'movieId Description',
// keywords: ['Plugin', 'Branch', 'Flutter'],
// publiclyIndex: true,
// locallyIndex: true,
// contentMetadata: BranchContentMetaData()
// ..addCustomMetadata('movieId', "${widget.movieId}10")
// ..addCustomMetadata('custom_bool', true)
// ..addCustomMetadata('custom_list_number', [1,2,3,4,5 ])
// ..addCustomMetadata('custom_list_string', ['a', 'b', 'c']),
// );
//
// BranchLinkProperties lp = BranchLinkProperties(
// channel: 'facebook',
// feature: 'sharing',
// stage: 'new share',
// tags: ['one', 'two', 'three']
// );
// lp.addControlParam('url', 'http://www.google.com');
// lp.addControlParam('url2', 'http://flutter.dev');
//
// BranchResponse response = await FlutterBranchSdk.showShareSheet(
// buo: buo,
// linkProperties: lp,
// messageText: 'My Share text',
// androidMessageTitle: 'My Message Title',
// androidSharingTitle: 'My Share with');
//
// if (response.success) {
// print('showShareSheet Sucess');
// } else {
// print('Error : ${response.errorCode} - ${response.errorMessage}');
// }
// },
// child: Container(
// width: 100,
// height: 100,
// color: Colors.black38,
// alignment: Alignment.center,
// child:const Text("share movie") ,
// ),
// )

// class DeepLinkServices {
//   AppLinks appLinks;
//   BuildContext context ;
//   GlobalKey<NavigatorState> navigatorKey;
//   DeepLinkServices(this.context , this.appLinks , this.navigatorKey);
//
//   StreamSubscription? _sub;
//
//   Future<void> initDeepLinksService() async {
//     _sub = appLinks.uriLinkStream.listen((Uri? uri) {
//       handleDeepLink(uri);
//     }, onError: (err) {
//       print('Error occurred: $err');
//     });
//
//   }
//
//   static const movies = '/movie';
//
//   void handleDeepLink(Uri? uri) {
//     if (uri != null) {
//       String path = uri.path;
//       Map<String, String> queryParams = uri.queryParameters;
//
//       if (path == movies) {
//         if (queryParams.containsKey('movieId')) {
//           String movieId = queryParams['movieId']!;
//
//           navigatorKey.currentState?.pushNamed(RoutesName.movieDetailScreen,
//               arguments: {"movieId": movieId});
//         } else {
//           navigatorKey.currentState?.pushNamed(RoutesName.homeScreen);
//         }
//       } else {
//         navigatorKey.currentState?.pushNamed(RoutesName.homeScreen);
//       }
//     }
//   }
// }
