import 'package:bloc/bloc.dart';

import '../../repo/search_coba_repository.dart';

part 'search_coba_event.dart';
part 'search_coba_state.dart';

class SearchCobaBloc extends Bloc<SearchingEvent, SearchCobaState> {
  final SearchCobaRepository repository;

  SearchCobaBloc({required this.repository}) : super(SearchingInitial()) {
    on<GetSearchEvent>((event, emit) async {
      emit(SearchingLoading());
      try {
        late List<dynamic> results;
        if (event.searchType == SearchType.nama) {
          results = await repository.searchByName(event.query, event.limit, event.offset);
        } else if (event.searchType == SearchType.kategoriProvinsi) {
          results = await repository.searchByProvince(event.query, event.limit, event.offset);
        } else if (event.searchType == SearchType.kategoriObjekWisata) {
          results = await repository.searchByCategory(event.query, event.limit, event.offset);
        }

        for (var result in results) {
          print('Response Objek Wisata: $result');
        }

        emit(SearchingLoaded(results: results));
      } catch (e) {
        print('Error during search: $e');
        emit(SearchingError());
      }
    });
  }
}
