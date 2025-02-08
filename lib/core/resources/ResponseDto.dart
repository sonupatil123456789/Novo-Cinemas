

class ResponseDto<T> {
  final bool success;
  final String message;
  final T data;

  ResponseDto({
    required this.success,
    required this.message,
    required this.data,
  });

  // fromJson method
  factory ResponseDto.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return ResponseDto(
      success: json['success'],
      message: json['message'],
      data: fromJsonT(json['data']),
    );
  }

  // toJson method
  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'success': success,
      'message': message,
      'data': toJsonT(data),
    };
  }

  // toString method
  @override
  String toString() {
    return 'ResponseDto(success: $success, message: $message, data: $data)';
  }
}
