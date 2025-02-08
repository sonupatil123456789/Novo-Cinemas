class TopUpModelRequest {
  final String cinemaId;
  final String itemId;
  final int variablePriceInCents;

  TopUpModelRequest({
    required this.cinemaId,
    required this.itemId,
    required this.variablePriceInCents,
  });

  factory TopUpModelRequest.fromJson(Map<String, dynamic> json) {
    return TopUpModelRequest(
      cinemaId: json['cinemaId'],
      itemId: json['itemId'],
      variablePriceInCents: json['variablePriceInCents'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cinemaId': cinemaId,
      'itemId': itemId,
      'variablePriceInCents': variablePriceInCents,
    };
  }
}

class TopUpModelResponse {
  final bool success;
  final String type;
  final String message;
  final TopUpResponseData data;

  TopUpModelResponse({
    required this.success,
    required this.type,
    required this.message,
    required this.data,
  });

  factory TopUpModelResponse.fromJson(Map<String, dynamic> json) {
    return TopUpModelResponse(
      success: json['success'],
      type: json['type'],
      message: json['message'],
      data: TopUpResponseData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'type': type,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class TopUpResponseData {
  final String reservationId;

  TopUpResponseData({
    required this.reservationId,
  });

  factory TopUpResponseData.fromJson(Map<String, dynamic> json) {
    return TopUpResponseData(
      reservationId: json['reservationId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reservationId': reservationId,
    };
  }
}
