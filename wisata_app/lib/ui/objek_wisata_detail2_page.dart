import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wisata_app/models/objek_wisata_model.dart';
import 'review_page.dart';

class ObjekWisataDetail2 extends StatelessWidget {
  final ObjekWisataModel objekWisataModel;

  ObjekWisataDetail2({required this.objekWisataModel});

  static const String baseUrl = 'http://10.0.2.2:8000/';

  @override
  Widget build(BuildContext context) {
    final imageUrl = '${objekWisataModel.foto}';

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Objek Wisata'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: Colors.green,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildFotoWidget(imageUrl),
                  SizedBox(height: 16.0),
                  ExpansionTile(
                    title: Text(
                      'Detail',
                      style: TextStyle(color: Colors.white),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              objekWisataModel.nama,
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  objekWisataModel.kategoriProvinsi,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  objekWisataModel.kategoriObjekWisata,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: [
                                Icon(Icons.location_on,
                                    color: Colors.white),
                                SizedBox(width: 8.0),
                                Expanded(
                                  child: Text(
                                    objekWisataModel.alamat,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              objekWisataModel.keterangan,
                              style: TextStyle(color: Colors.white, fontSize: 16.0,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Container(
            color: Color(0xFF0F2F00),
            child: ExpansionTile(
              initiallyExpanded: false,
              title: Text(
                'Operasional',
                style: TextStyle(color: Colors.white),
              ),
              children: objekWisataModel.operasional
                  .map((op) => ListTile(
                title: Text(
                  op.hariOperasional,
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  '${op.jamBuka} - ${op.jamTutup}\nTarif: ${op.tarif}',
                  style: TextStyle(color: Colors.white),
                ),
              ))
                  .toList(),
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReviewPage(),
                ),
              );
            },
            child:
            Text('Review', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildFotoWidget(String? imageUrl) {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return Image.network(
        imageUrl,
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return Image.asset(
            'assets/default.jpg',
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          );
        },
      );
    } else {
      return Image.asset(
        'assets/default.jpg',
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
      );
    }
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch $url';
    }
  }
}
