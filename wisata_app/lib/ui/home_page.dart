import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wisata_app/core/session_manager.dart';
import 'package:wisata_app/ui/profile_page.dart';
import 'package:wisata_app/ui/search_coba_page.dart';

import '../bloc/objek_wisata/pagination/objek_wisata_pagination_bloc.dart';
import '../cubit/setting_app_cubit.dart';
import 'login_page.dart';
import 'objek_wisata_detail2_page.dart';
import 'objek_wisata_detail_page.dart';
import 'objek_wisata_pagi_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final sessionManager = SessionManager();
  final ScrollController scrollController = ScrollController();
  late ObjekWisataPaginationBloc objekWisataPaginationBloc;

  @override
  void initState() {
    super.initState();
    objekWisataPaginationBloc =
    BlocProvider.of<ObjekWisataPaginationBloc>(context)
      ..add(GetObjekWisataPaginationEvent());
    scrollController.addListener(onScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void onScroll() {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;
    if (maxScroll == currentScroll) {
      objekWisataPaginationBloc.add(GetObjekWisataPaginationEvent());
    }
  }

  void _navigateToAllObjekWisata() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ObjekWisataPagiPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi Wisata'),
        backgroundColor: Colors.white,
        elevation: 5,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Halo ${sessionManager.getActiveFirstname()} ${sessionManager.getActiveLastname()}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A5319)),
                ),
                Spacer(),
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(sessionManager.getActiveFoto() ?? ''),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Mulailah, Temukan Destinasi Impian Anda!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1A5319)),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchCobaPage(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        children: [
                          Icon(Icons.search),
                          SizedBox(width: 8),
                          Text('Search'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchCobaPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Destinasi Wisata',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A5319)),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<ObjekWisataPaginationBloc,
                  ObjekWisataPaginationState>(
                builder: (context, state) {
                  if (state is ObjekWisataPaginationInitial) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ObjekWisataPaginationError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else if (state is ObjekWisataPaginationLoaded) {
                    if (state.listObjekWisataModel.isEmpty) {
                      return const Center(
                        child: Text('Data masih kosong'),
                      );
                    }
                    return Column(
                      children: [
                        Container(
                          height: 270,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            controller: scrollController,
                            itemCount: state.listObjekWisataModel.length,
                            itemBuilder: (_, index) {
                              var wisataItem =
                              state.listObjekWisataModel[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ObjekWisataDetail2(objekWisataModel: wisataItem),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 16),
                                  width: 150,
                                  child: Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        color: const Color(0xFFD8D9DA),
                                      ),
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            child: wisataItem.foto != null &&
                                                wisataItem
                                                    .foto!.isNotEmpty
                                                ? Image.network(
                                              wisataItem.foto!,
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
                                          const SizedBox(height: 8),
                                          Text(
                                            wisataItem.nama ??
                                                'Nama tidak tersedia',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            wisataItem.kategoriProvinsi ??
                                                'Provinsi tidak tersedia',
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _navigateToAllObjekWisata,
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF1A5319),
                            onPrimary: Colors.white,
                          ),
                          child: const Text(
                            'Tampilkan Selengkapnya',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  context.read<SettingAppCubit>().signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                        (Route<dynamic> route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF1A5319),
                  onPrimary: Colors.white,
                ),
                child: const Text('Sign Out'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ),
            );
          }
        },
        selectedIconTheme: IconThemeData(color: Colors.black),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.rate_review), label: 'Review'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
