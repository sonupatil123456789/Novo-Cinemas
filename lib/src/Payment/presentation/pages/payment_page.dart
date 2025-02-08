import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/src/Payment/domain/usecases/create_payment.dart';
import 'package:novocinema/src/Payment/presentation/blocs/payment_event.dart';
import 'package:novocinema/src/Payment/presentation/blocs/payment_state.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

import '../blocs/payment_bloc.dart';

class PaymentPage extends StatefulWidget {
  final String reservationId;

  const PaymentPage({super.key, required this.reservationId});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late final WebViewControllerPlus _webViewController;

  @override
  void initState() {
    super.initState();
    // Initialize the WebViewController
    _webViewController = WebViewControllerPlus()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.error != null) {
            return Center(child: Text('Error: ${state.error}'));
          } else if (state.paymentResponse != null) {
            print(state.paymentResponse.mobileAppHtml.replaceAll(r'\"', '"'));
            // _webViewController.loadHtmlString(
            //   state.paymentResponse.mobileAppHtml
            //       .replaceAll(RegExp(r'\\\"'), '"'),
            // );
            _webViewController.loadRequest(Uri.parse(
                'https://payment2.binarynumbers.io/web/index2.html?reservation-id=${widget.reservationId}'));

            return WebViewWidget(
              controller: _webViewController,
            );
          }
          return Center(
            child: ElevatedButton(
              onPressed: () {
                context
                    .read<PaymentBloc>()
                    .add(CreatePaymentEvent(widget.reservationId));
              },
              child: const Text('Start Payment'),
            ),
          );
        },
      ),
    );
  }
}
