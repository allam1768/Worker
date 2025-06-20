// alat_model.dart
class AlatModel {
  final int id;
  final int? companyId; // Add company_id field
  final String namaAlat;
  final String lokasi;
  final String detailLokasi;
  final String pestType;
  final String kondisi;
  final String kodeQr;
  final String? imagePath;
  final CompanyInfo? company; // Add company info

  AlatModel({
    required this.id,
    this.companyId,
    required this.namaAlat,
    required this.lokasi,
    required this.detailLokasi,
    required this.pestType,
    required this.kondisi,
    required this.kodeQr,
    this.imagePath,
    this.company,
  });

  factory AlatModel.fromJson(Map<String, dynamic> json) {
    return AlatModel(
      id: json['id'] ?? 0,
      companyId: json['company_id'],
      namaAlat: json['nama_alat'] ?? '',
      lokasi: json['lokasi'] ?? '',
      detailLokasi: json['detail_lokasi'] ?? '',
      pestType: json['pest_type'] ?? '',
      kondisi: json['kondisi'] ?? '',
      kodeQr: json['kode_qr'] ?? '',
      imagePath: json['alat_image'] != null && json['alat_image'].toString().isNotEmpty
          ? 'https://hamatech.rplrus.com/storage/${json['alat_image']}'
          : null,
      company: json['company'] != null ? CompanyInfo.fromJson(json['company']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'nama_alat': namaAlat,
      'lokasi': lokasi,
      'detail_lokasi': detailLokasi,
      'pest_type': pestType,
      'kondisi': kondisi,
      'kode_qr': kodeQr,
      'alat_image': imagePath,
      'company': company?.toJson(),
    };
  }
}

// Model untuk company info dalam response alat
class CompanyInfo {
  final int id;
  final String name;

  CompanyInfo({
    required this.id,
    required this.name,
  });

  factory CompanyInfo.fromJson(Map<String, dynamic> json) {
    return CompanyInfo(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}