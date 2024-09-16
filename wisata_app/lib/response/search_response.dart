import 'package:wisata_app/models/objek_wisata_model.dart';

class SearchResponse {
  final List<ObjekWisataModel> objekWisataList;

  SearchResponse({required this.objekWisataList});

  factory SearchResponse.fromJson(List<dynamic> json) {
    return SearchResponse(
      objekWisataList: json
          .map((objekWisataJson) => ObjekWisataModel.fromJson(objekWisataJson))
          .toList(),
    );
  }

  List<Map<String, dynamic>> toJson() {
    return objekWisataList.map((objekWisata) => objekWisata.toJson()).toList();
  }
}
