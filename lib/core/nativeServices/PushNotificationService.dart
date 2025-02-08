import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../constants/RoutesName.dart';
import 'DeepLinkServices.dart';

class PushNotificationService {
  BuildContext context;
  GlobalKey<NavigatorState> navigatorKey;
  PushNotificationService(this.context, this.navigatorKey);

  StreamSubscription? _sub;

  Future<void> initOnClickNotification() async {
    try {
      OneSignal.Notifications.addClickListener((OSNotificationClickEvent event) {
        onClickNotification(event);
      });
    } on PlatformException catch (error) {
      navigator(RoutesName.movieDetailScreen, null);
    }
  }

  void onClickNotification(OSNotificationClickEvent data) {
    var response = data.notification.additionalData;

    if (response != null) {
      if (response.containsKey(MOVIE_KEY)) {
        String movieId = response['movieId'];
        String imageUrl = response['imageUrl'];
        navigator(RoutesName.movieDetailScreen, {MOVIE_KEY: movieId, MOVIE_IMAGE_URL : imageUrl});
      } else {
        navigator(RoutesName.movieDetailScreen, null);
      }
    } else {
      navigator(RoutesName.movieDetailScreen, null);
    }
  }


  void navigator(routeName, Map<String, dynamic>? arguments) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }
}

// event.notification.jsonRepresentation();
// event.notification.additionalData;