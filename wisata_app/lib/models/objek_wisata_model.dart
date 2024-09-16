import 'dart:convert';

class ObjekWisataModel {
  final int id;
  final String nama;
  final String alamat;
  final String keterangan;
  final String rating;
  final String ulasan;
  final String foto;
  final String linkGmaps;
  final String kategoriProvinsi;
  final String kategoriObjekWisata;
  final List<Operasional> operasional;

  ObjekWisataModel({
    required this.id,
    required this.nama,
    required this.alamat,
    required this.keterangan,
    required this.rating,
    required this.ulasan,
    required this.foto,
    required this.linkGmaps,
    required this.kategoriProvinsi,
    required this.kategoriObjekWisata,
    required this.operasional,
  });

  factory ObjekWisataModel.fromJson(Map<String, dynamic> json) {
    return ObjekWisataModel(
      id: json['id'],
      nama: json['nama'],
      alamat: json['alamat'],
      keterangan: json['keterangan'],
      rating: json['rating'],
      ulasan: json['ulasan'],
      foto: json['foto'],
      linkGmaps: json['link_gmaps'],
      kategoriProvinsi: json['kategori_provinsi'],
      kategoriObjekWisata: json['kategori_objek_wisata'],
      operasional: (json['operasional'] as List)
          .map((i) => Operasional.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'alamat': alamat,
      'keterangan': keterangan,
      'rating': rating,
      'ulasan': ulasan,
      'foto': foto,
      'link_gmaps': linkGmaps,
      'kategori_provinsi': kategoriProvinsi,
      'kategori_objek_wisata': kategoriObjekWisata,
      'operasional': operasional.map((op) => op.toJson()).toList(),
    };
  }
}

class Operasional {
  final String hariOperasional;
  final String jamBuka;
  final String jamTutup;
  final String tarif;

  Operasional({
    required this.hariOperasional,
    required this.jamBuka,
    required this.jamTutup,
    required this.tarif,
  });

  factory Operasional.fromJson(Map<String, dynamic> json) {
    return Operasional(
      hariOperasional: json['hari_operasional'],
      jamBuka: json['jam_buka'],
      jamTutup: json['jam_tutup'],
      tarif: json['tarif'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hari_operasional': hariOperasional,
      'jam_buka': jamBuka,
      'jam_tutup': jamTutup,
      'tarif': tarif,
    };
  }
}
