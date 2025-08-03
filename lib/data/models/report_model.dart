class ReportResponse {
  final bool success;
  final ReportData? data;
  final String message;

  ReportResponse({
    required this.success,
    this.data,
    required this.message,
  });

  factory ReportResponse.fromJson(Map<String, dynamic> json) {
    return ReportResponse(
      success: json['success'] ?? false,
      data: json['data'] != null ? ReportData.fromJson(json['data']) : null,
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
      'message': message,
    };
  }
}

class ReportData {
  final int id;
  final String namaPengirim;
  final String area;
  final String informasi;
  final String companyId;
  final String createdAt;
  final String updatedAt;
  final Company? company;

  ReportData({
    required this.id,
    required this.namaPengirim,
    required this.area,
    required this.informasi,
    required this.companyId,
    required this.createdAt,
    required this.updatedAt,
    this.company,
  });

  factory ReportData.fromJson(Map<String, dynamic> json) {
    return ReportData(
      id: json['id'] ?? 0,
      namaPengirim: json['nama_pengirim'] ?? '',
      area: json['area'] ?? '',
      informasi: json['informasi'] ?? '',
      companyId: json['company_id']?.toString() ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      company: json['company'] != null ? Company.fromJson(json['company']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_pengirim': namaPengirim,
      'area': area,
      'informasi': informasi,
      'company_id': companyId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'company': company?.toJson(),
    };
  }
}

class Company {
  final int id;
  final int clientId;
  final String name;
  final String companyQr;
  final String address;
  final String phoneNumber;
  final String email;
  final String? image;
  final String createdAt;
  final String updatedAt;

  Company({
    required this.id,
    required this.clientId,
    required this.name,
    required this.companyQr,
    required this.address,
    required this.phoneNumber,
    required this.email,
    this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'] ?? 0,
      clientId: json['client_id'] ?? 0,
      name: json['name'] ?? '',
      companyQr: json['company_qr'] ?? '',
      address: json['address'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      email: json['email'] ?? '',
      image: json['image'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client_id': clientId,
      'name': name,
      'company_qr': companyQr,
      'address': address,
      'phone_number': phoneNumber,
      'email': email,
      'image': image,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

// Request model for sending report
class ReportRequest {
  final String namaPengirim;
  final String area;
  final String informasi;
  final String companyId;

  ReportRequest({
    required this.namaPengirim,
    required this.area,
    required this.informasi,
    required this.companyId,
  });

  Map<String, dynamic> toJson() {
    return {
      'nama_pengirim': namaPengirim,
      'area': area,
      'informasi': informasi,
      'company_id': companyId,
    };
  }
}

// Error response model
class ApiErrorResponse {
  final bool success;
  final String message;
  final Map<String, dynamic>? errors;

  ApiErrorResponse({
    required this.success,
    required this.message,
    this.errors,
  });

  factory ApiErrorResponse.fromJson(Map<String, dynamic> json) {
    return ApiErrorResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? 'Unknown error',
      errors: json['errors'],
    );
  }
}