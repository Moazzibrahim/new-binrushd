class IndividualBranchModel {
  String message;
  BranchData data;

  IndividualBranchModel({required this.message, required this.data});

  factory IndividualBranchModel.fromJson(Map<String, dynamic> json) {
    return IndividualBranchModel(
      message: json['message'],
      data: BranchData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
    };
  }
}

class BranchData {
  int id;
  String name;
  String brief;
  String address;
  double latitude;
  double longitude;
  WorkTimes worktimes;
  String email;
  String image;
  List<Department> departments;
  DoctorData doctors;

  BranchData({
    required this.id,
    required this.name,
    required this.brief,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.worktimes,
    required this.email,
    required this.image,
    required this.departments,
    required this.doctors,
  });

  factory BranchData.fromJson(Map<String, dynamic> json) {
    return BranchData(
      id: json['id'],
      name: json['name'],
      brief: json['brief'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      worktimes: WorkTimes.fromJson(json['worktimes']),
      email: json['email'],
      image: json['image'],
      departments: (json['departments'] as List)
          .map((e) => Department.fromJson(e))
          .toList(),
      doctors: DoctorData.fromJson(json['doctors']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brief': brief,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'worktimes': worktimes.toJson(),
      'email': email,
      'image': image,
      'departments': departments.map((e) => e.toJson()).toList(),
      'doctors': doctors.toJson(),
    };
  }
}

class WorkTimes {
  String sunday;
  String monday;
  String tuesday;
  String wednesday;
  String thursday;
  String friday;
  String saturday;

  WorkTimes({
    required this.sunday,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
  });

  factory WorkTimes.fromJson(Map<String, dynamic> json) {
    return WorkTimes(
      sunday: json['sunday'],
      monday: json['monday'],
      tuesday: json['tuesday'],
      wednesday: json['wednesday'],
      thursday: json['thursday'],
      friday: json['friday'],
      saturday: json['saturday'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sunday': sunday,
      'monday': monday,
      'tuesday': tuesday,
      'wednesday': wednesday,
      'thursday': thursday,
      'friday': friday,
      'saturday': saturday,
    };
  }
}

class Department {
  int id;
  String name;
  int branchId;
  String image;

  Department({
    required this.id,
    required this.name,
    required this.branchId,
    required this.image,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'],
      name: json['name'],
      branchId: json['branch_id'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'branch_id': branchId,
      'image': image,
    };
  }
}

class DoctorData {
  List<Doctor> data;
  DoctorLinks links;
  DoctorMeta meta;

  DoctorData({
    required this.data,
    required this.links,
    required this.meta,
  });

  factory DoctorData.fromJson(Map<String, dynamic> json) {
    return DoctorData(
      data: (json['data'] as List).map((e) => Doctor.fromJson(e)).toList(),
      links: DoctorLinks.fromJson(json['links']),
      meta: DoctorMeta.fromJson(json['meta']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()).toList(),
      'links': links.toJson(),
      'meta': meta.toJson(),
    };
  }
}

class Doctor {
  int id;
  String fname;
  String lname;
  String speciality;
  String? phone;
  String? email;
  String image;

  Doctor({
    required this.id,
    required this.fname,
    required this.lname,
    required this.speciality,
    this.phone,
    this.email,
    required this.image,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      fname: json['fname'],
      lname: json['lname'],
      speciality: json['Speciality'],
      phone: json['phone'],
      email: json['email'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fname': fname,
      'lname': lname,
      'Speciality': speciality,
      'phone': phone,
      'email': email,
      'image': image,
    };
  }
}

class DoctorLinks {
  String first;
  String last;
  String? prev;
  String? next;

  DoctorLinks({
    required this.first,
    required this.last,
    this.prev,
    this.next,
  });

  factory DoctorLinks.fromJson(Map<String, dynamic> json) {
    return DoctorLinks(
      first: json['first'],
      last: json['last'],
      prev: json['prev'],
      next: json['next'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first': first,
      'last': last,
      'prev': prev,
      'next': next,
    };
  }
}

class DoctorMeta {
  int currentPage;
  int from;
  int lastPage;
  int perPage;
  int to;
  int total;

  DoctorMeta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory DoctorMeta.fromJson(Map<String, dynamic> json) {
    return DoctorMeta(
      currentPage: json['current_page'],
      from: json['from'],
      lastPage: json['last_page'],
      perPage: json['per_page'],
      to: json['to'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'from': from,
      'last_page': lastPage,
      'per_page': perPage,
      'to': to,
      'total': total,
    };
  }
}
