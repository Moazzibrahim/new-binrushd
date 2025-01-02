class AuthUserResponse {
  final String message;
  final AuthUserData data;

  AuthUserResponse({required this.message, required this.data});

  factory AuthUserResponse.fromJson(Map<String, dynamic> json) {
    return AuthUserResponse(
      message: json['message'],
      data: AuthUserData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
    };
  }
}

class AuthUserData {
  final int id;
  final String fname;
  final String lname;
  final String mobile;
  final String email;
  final String role;
  final String? emailVerifiedAt;
  final dynamic createdBy;
  final String createdAt;
  final String updatedAt;

  AuthUserData({
    required this.id,
    required this.fname,
    required this.lname,
    required this.mobile,
    required this.email,
    required this.role,
    this.emailVerifiedAt,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AuthUserData.fromJson(Map<String, dynamic> json) {
    return AuthUserData(
      id: json['id'],
      fname: json['fname'],
      lname: json['lname'],
      mobile: json['mobile'],
      email: json['email'],
      role: json['role'],
      emailVerifiedAt: json['email_verified_at'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fname': fname,
      'lname': lname,
      'mobile': mobile,
      'email': email,
      'role': role,
      'email_verified_at': emailVerifiedAt,
      'created_by': createdBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
