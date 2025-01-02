class DepartmentResponse {
  final String message;
  final List<Department> data;

  DepartmentResponse({required this.message, required this.data});

  factory DepartmentResponse.fromJson(Map<String, dynamic> json) {
    return DepartmentResponse(
      message: json['message'],
      data: List<Department>.from(
        json['data'].map((department) => Department.fromJson(department)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.map((department) => department.toJson()).toList(),
    };
  }
}

class Department {
  final int id;
  final String name;
  final String brief;
  final int branchId;
  final String image;

  Department({
    required this.id,
    required this.name,
    required this.brief,
    required this.branchId,
    required this.image,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'],
      name: json['name'],
      brief: json['brief'],
      branchId: json['branch_id'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brief': brief,
      'branch_id': branchId,
      'image': image,
    };
  }
}
