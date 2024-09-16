class SearchModel {
  final String? keyword;
  final String kategoriProvinsi;
  final String kategoriObjekWisata;

  SearchModel({this.keyword, required this.kategoriProvinsi, required this.kategoriObjekWisata});

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      keyword: json['nama'],
      kategoriProvinsi: json['kategori_provinsi'],
      kategoriObjekWisata: json['kategori_objek_wisata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': keyword,
      'kategori_provinsi': kategoriProvinsi,
      'kategori_objek_wisata': kategoriObjekWisata,
    };
  }
}
