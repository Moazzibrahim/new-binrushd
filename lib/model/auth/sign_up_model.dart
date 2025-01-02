class RegistrationResponse {
  final String message;
  final Data data;

  RegistrationResponse({
    required this.message,
    required this.data,
  });

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) {
    return RegistrationResponse(
      message: json['message'] as String,
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
    };
  }
}

class Data {
  final String token;

  Data({
    required this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
    };
  }
}
