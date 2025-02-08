class ResponseData<T> {
  final bool success;
  final String message;
  final T data;
  final int statusCode;
  final String type;


  ResponseData({
    required this.success,
    required this.message,
    required this.data,
    required this.statusCode,
    required this.type,
  });

  // fromJson method
  factory ResponseData.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return ResponseData(
      success: json['success'],
      message: json['message'],
      data: fromJsonT(json['data']),
      statusCode: json['statusCode'],
      type: json['type'],
    );
  }

  // toJson method
  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'success': success,
      'message': message,
      'data': toJsonT(data),
      'statusCode': statusCode,
      'type': type,
    };
  }

  // toString method
  @override
  String toString() {
    return 'ResponseData(success: $success, message: $message, type: $type, statusCode: $statusCode, data: $data,)';
  }
}