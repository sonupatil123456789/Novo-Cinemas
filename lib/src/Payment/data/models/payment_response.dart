class PaymentResponse {
  final bool success;
  final String message;
  final String mobileAppHtml;

  PaymentResponse({required this.success, required this.message, required this.mobileAppHtml});

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      success: json['success'],
      message: json['message'],
      mobileAppHtml: json['data']['mobileAppHtml'],
    );
  }
}