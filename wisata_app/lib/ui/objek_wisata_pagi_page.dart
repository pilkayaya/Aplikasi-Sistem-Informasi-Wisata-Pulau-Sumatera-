import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wisata_app/bloc/objek_wisata/pagination/objek_wisata_pagination_bloc.dart';

import 'objek_wisata_detail2_page.dart';

class ObjekWisataPagiPage extends StatefulWidget {
  ObjekWisataPagiPage({Key? key}) : super(key: key);

  @override
  State<ObjekWisataPagiPage> createState() => _ObjekWisataPagiPageState();
}

class _ObjekWisataPagiPageState extends State<ObjekWisataPagiPage> {
  final ScrollController scrollController = ScrollController();

  void onScroll() {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;
    if (maxScroll == currentScroll) {
      context.read<ObjekWisataPaginationBloc>().add(GetObjekWisataPaginationEvent());
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(onScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Objek Wisata'),
      ),
      body: BlocBuilder<ObjekWisataPaginationBloc, ObjekWisataPaginationState>(
        builder: (context, state) {
          if (state is ObjekWisataPaginationInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ObjekWisataPaginationError) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is ObjekWisataPaginationLoaded) {
            if (state.listObjekWisataModel.isEmpty) {
              return Center(
                child: Text('Data masih kosong'),
              );
            }
            return ListView.builder(
              controller: scrollController,
              itemCount: state.hasReachedMax
                  ? state.listObjekWisataModel.length
                  : state.listObjekWisataModel.length + 1,
              itemBuilder: (_, index) {
                if (index < state.listObjekWisataModel.length) {
                  var wisataItem = state.listObjekWisataModel[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ObjekWisataDetail2(objekWisataModel: wisataItem),
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
                            color: Color(0xFFD8D9DA),
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: wisataItem.foto != null && wisataItem.foto!.isNotEmpty
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
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      wisataItem.nama.toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.black,
                                          size: 16,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          wisataItem.kategoriProvinsi.toString(),
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
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
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
