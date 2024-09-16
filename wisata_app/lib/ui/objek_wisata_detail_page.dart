import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wisata_app/bloc/objek_wisata/detail/objek_wisata_detail_bloc.dart';
import '../repo/objek_wisata_repository.dart';

class ObjekWisataDetailPage extends StatelessWidget {
  final int objekWisataId;

  ObjekWisataDetailPage({required this.objekWisataId});

  static const String baseUrl = 'http://10.0.2.2:8000/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Objek Wisata'),
      ),
      body: BlocProvider(
        create: (context) => ObjekWisataDetailBloc(
          RepositoryProvider.of<ObjekWisataRepository>(context),
        )..add(GetObjekWisataDetailEvent(objekWisataId)),
        child: BlocBuilder<ObjekWisataDetailBloc, ObjekWisataDetailState>(
          builder: (context, state) {
            if (state is ObjekWisataDetailLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ObjekWisataDetailLoaded) {
              final objekWisata = state.objekWisata;

              print('URL Foto: ${objekWisata.foto}');
              final imageUrl = '$baseUrl${objekWisata.foto}';

              return ListView(
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
                                      objekWisata.nama,
                                      style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          objekWisata.kategoriProvinsi,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          objekWisata.kategoriObjekWisata,
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
                                            objekWisata.alamat,
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16.0),
                                    Text(
                                      objekWisata.keterangan,
                                      style: TextStyle(color: Colors.white),
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
                  SizedBox(
                      height: 16.0),
                  Container(
                    color: Color(0xFF0F2F00),
                    child: ExpansionTile(
                      initiallyExpanded: false,
                      title: Text(
                        'Operasional',
                        style: TextStyle(color: Colors.white),
                      ),
                      children: objekWisata.operasional
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
                  SizedBox(
                      height:
                          16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: () {
                      _launchURL(objekWisata.linkGmaps);
                    },
                    child: Text('Google Maps',
                        style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: () {
                      // navigasi ke halaman review
                    },
                    child:
                        Text('Review', style: TextStyle(color: Colors.white)),
                  ),
                ],
              );
            } else if (state is ObjekWisataDetailError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text('Unknown state'));
            }
          },
        ),
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
