class CompanyModel {
  final int id;
  final String name;
  final String address;
  final String phoneNumber;
  final String email;
  final String? imagePath;
  final String? companyQr;
  final String createdAt;
  final String updatedAt;
  final int? clientId; // Added for client_id
  final int? alatCount; // Added for alat_count
  final ClientInfo? client; // Added for client info

  CompanyModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.email,
    this.imagePath,
    this.companyQr,
    required this.createdAt,
    required this.updatedAt,
    this.clientId,
    this.alatCount,
    this.client,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      email: json['email'] ?? '',
      imagePath: json['image'] != null && json['image'].toString().isNotEmpty
          ? 'https://hamatech.rplrus.com/storage/${json['image']}'
          : null,
      companyQr: json['company_qr'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      clientId: json['client_id'],
      alatCount: json['alat_count'],
      client: json['client'] != null ? ClientInfo.fromJson(json['client']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone_number': phoneNumber,
      'email': email,
      'image': imagePath,
      'company_qr': companyQr,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'client_id': clientId,
      'alat_count': alatCount,
      'client': client?.toJson(),
    };
  }
}

class ClientInfo {
  final int id;
  final String name;
  final String email;

  ClientInfo({
    required this.id,
    required this.name,
    required this.email,
  });

  factory ClientInfo.fromJson(Map<String, dynamic> json) {
    return ClientInfo(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}