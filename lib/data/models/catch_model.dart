class CatchModel {
  final int? id;
  final String alatId;
  final String jenisHama;
  final int jumlah;
  final String tanggal;
  final String dicatatOleh;
  final String fotoDokumentasi;
  final String kondisi;
  final String catatan;
  final String? updatedAt;
  final String? createdAt;

  CatchModel({
    this.id,
    required this.alatId,
    required this.jenisHama,
    required this.jumlah,
    required this.tanggal,
    required this.dicatatOleh,
    required this.fotoDokumentasi,
    required this.kondisi,
    required this.catatan,
    this.updatedAt,
    this.createdAt,
  });

  factory CatchModel.fromJson(Map<String, dynamic> json) {
    return CatchModel(
      id: json['id'],
      alatId: json['alat_id'],
      jenisHama: json['jenis_hama'],
      jumlah: json['jumlah'],
      tanggal: json['tanggal'],
      dicatatOleh: json['dicatat_oleh'],
      fotoDokumentasi: json['foto_dokumentasi'],
      kondisi: json['kondisi'],
      catatan: json['catatan'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'alat_id': alatId,
      'jenis_hama': jenisHama,
      'jumlah': jumlah,
      'tanggal': tanggal,
      'dicatat_oleh': dicatatOleh,
      'foto_dokumentasi': fotoDokumentasi,
      'kondisi': kondisi,
      'catatan': catatan,
    };
  }
}
