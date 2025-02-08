



import 'package:flutter/material.dart';
import 'package:novocinema/components/ArtBoard.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'BackButtonNavbar.dart';

class CustomInAppWebView extends StatefulWidget {
  final String url ;


  const CustomInAppWebView({super.key, required this.url});

  @override
  State<CustomInAppWebView> createState() => _CustomInAppWebViewState();
}

class _CustomInAppWebViewState extends State<CustomInAppWebView> {

  late final WebViewController _controller ;


  @override
  void initState() {

    _controller  = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://flutter.dev'));
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return ArtBoard(
      header: BackButtonNavBar(onBackPress: () {
        Navigator.pop(context);
      }),
      body: PopScope(
        onPopInvokedWithResult:(didPop, result) {
        },
        child: WebViewWidget(controller: _controller)
      ),

    );
  }
}
