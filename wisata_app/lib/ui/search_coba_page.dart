import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wisata_app/bloc/search_coba/search_coba_bloc.dart';
import 'package:wisata_app/models/objek_wisata_model.dart';
import 'package:wisata_app/ui/objek_wisata_detail2_page.dart';

class SearchCobaPage extends StatefulWidget {
  @override
  _SearchCobaPageState createState() => _SearchCobaPageState();
}

class _SearchCobaPageState extends State<SearchCobaPage> {
  final TextEditingController _searchController = TextEditingController();
  late SearchCobaBloc _searchBloc;

  List<String> provinceCategories = [
    'Aceh',
    'Sumatera Utara',
    'Sumatera Barat',
    'Riau',
    'Kepulauan Riau',
    'Jambi',
    'Bengkulu',
    'Sumatera Selatan',
    'Bangka Belitung',
    'Lampung',
  ];

  List<String> attractionCategories = [
    'Wisata Alam',
    'Wisata Budaya',
    'Wisata Edukasi',
    'Wisata Petualangan',
    'Wisata Hiburan',
    'Wisata Kuliner',
    'Wisata Belanja',
    'Wisata Religius',
  ];

  String selectedProvinceCategory = '';
  String selectedAttractionCategory = '';

  @override
  void initState() {
    super.initState();
    _searchBloc = BlocProvider.of<SearchCobaBloc>(context);
  }

  void _performSearch(String query, SearchType searchType) {
    int limit = 10;
    int offset = 0;

    print(
        "Performing search with query: $query and type: $searchType"); // Logging
    _searchBloc.add(GetSearchEvent(
        query: query, searchType: searchType, limit: limit, offset: offset));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter Berdasarkan:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari di sini',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    String query = _searchController.text.trim();
                    if (query.isNotEmpty) {
                      _performSearch(query, SearchType.nama);
                    }
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding: EdgeInsets.all(8.0),
              ),
            ),
            SizedBox(height: 16),
            _buildProvinceFilterButtons(),
            SizedBox(height: 16),
            Divider(), // Divider for separation
            SizedBox(height: 16),
            _buildAttractionFilterButtons(),
            SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<SearchCobaBloc, SearchCobaState>(
                builder: (context, state) {
                  if (state is SearchingLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is SearchingLoaded) {
                    List<dynamic> results = state.results;
                    return _buildSearchResults(results);
                  } else if (state is SearchingError) {
                    return Center(
                      child: Text('Error searching'),
                    );
                  } else {
                    return Center(
                      child: Text('Cari sesuatu'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProvinceFilterButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Kategori Provinsi',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold, color: Color(0xFF1A5319)
            ),
          ),
        ),
        SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 16),
              for (String category in provinceCategories)
                _buildFilterButton(
                  text: category,
                  onPressed: () {
                    setState(() {
                      selectedProvinceCategory = category;
                    });
                    _performSearch(
                        selectedProvinceCategory, SearchType.kategoriProvinsi);
                  },
                ),
              SizedBox(width: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAttractionFilterButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Kategori Objek Wisata',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold, color: Color(0xFF1A5319)
            ),
          ),
        ),
        SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 16),
              for (String category in attractionCategories)
                _buildFilterButton(
                  text: category,
                  onPressed: () {
                    setState(() {
                      selectedAttractionCategory = category;
                    });
                    _performSearch(selectedAttractionCategory,
                        SearchType.kategoriObjekWisata);
                  },
                ),
              SizedBox(width: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterButton(
      {required String text, required VoidCallback onPressed}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF1A5319), // Warna hijau
          onPrimary: Colors.white,
        ),
        child: Text(text),
      ),
    );
  }

  Widget _buildSearchResults(List<dynamic> results) {
    if (results.isEmpty) {
      return Center(
        child: Text('No results found'),
      );
    }
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        var result = results[index];
        if (result is ObjekWisataModel) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ObjekWisataDetail2(objekWisataModel: result),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF828282),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: result.foto != null && result.foto!.isNotEmpty
                            ? Image.network(
                                result.foto!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/default.jpg',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              result.nama.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  result.kategoriProvinsi.toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
