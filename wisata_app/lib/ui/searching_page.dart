import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wisata_app/bloc/search/search_bloc.dart';
import 'package:wisata_app/models/search_model.dart';
import 'package:wisata_app/models/objek_wisata_model.dart';
import '../bloc/search/search_event.dart';
import '../bloc/search/search_state.dart';
import 'objek_wisata_detail_page.dart';

class SearchingPage extends StatefulWidget {
  @override
  _SearchingPageState createState() => _SearchingPageState();
}

class _SearchingPageState extends State<SearchingPage> {
  String? _selectedProvinsi;
  String? _selectedKategoriWisata;
  final TextEditingController _keywordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Material(
              child: TextField(
                controller: _keywordController,
                decoration: InputDecoration(
                  labelText: 'Keyword',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 10),
            Material(
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Kategori Provinsi'),
                value: _selectedProvinsi,
                items: [
                  'Aceh', 'Sumatera Utara', 'Sumatera Barat', 'Riau', 'Kepulauan Riau',
                  'Jambi', 'Bengkulu', 'Sumatera Selatan', 'Bangka Belitung', 'Lampung'
                ].map((provinsi) {
                  return DropdownMenuItem<String>(
                    value: provinsi,
                    child: Text(provinsi),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedProvinsi = value;
                  });
                },
              ),
            ),
            SizedBox(height: 10),
            Material(
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Kategori Objek Wisata'),
                value: _selectedKategoriWisata,
                items: [
                  'Wisata Alam', 'Wisata Budaya', 'Wisata Edukasi', 'Wisata Petualangan',
                  'Wisata Hiburan', 'Wisata Kuliner', 'Wisata Belanja', 'Wisata Religius'
                ].map((kategori) {
                  return DropdownMenuItem<String>(
                    value: kategori,
                    child: Text(kategori),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedKategoriWisata = value;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_selectedProvinsi != null || _selectedKategoriWisata != null || _keywordController.text.isNotEmpty) {
                  final searchModel = SearchModel(
                    kategoriProvinsi: _selectedProvinsi ?? '',
                    kategoriObjekWisata: _selectedKategoriWisata ?? '',
                    keyword: _keywordController.text,
                  );
                  context.read<SearchBloc>().add(SearchWisataEvent(searchModel));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Silakan isi setidaknya salah satu kriteria pencarian')),
                  );
                }
              },
              child: Text('Cari'),
            ),
            SizedBox(height: 20),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is SearchLoaded) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.objekWisataList.length,
                    itemBuilder: (context, index) {
                      final objekWisata = state.objekWisataList[index];
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ObjekWisataDetailPage(objekWisataId: objekWisata.id),
                              ),
                            );
                          },
                          leading: objekWisata.foto != null ? Image.network(objekWisata.foto!) : null,
                          title: Text(objekWisata.nama ?? ''),
                          subtitle: Text(objekWisata.kategoriProvinsi ?? ''),
                          trailing: Icon(Icons.arrow_forward),
                        ),
                      );
                    },
                  );
                } else if (state is SearchError) {
                  return Center(child: Text(state.message));
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
