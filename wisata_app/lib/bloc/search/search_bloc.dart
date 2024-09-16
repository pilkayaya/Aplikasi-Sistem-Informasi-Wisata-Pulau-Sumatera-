import 'package:bloc/bloc.dart';
import 'package:wisata_app/bloc/search/search_event.dart';
import 'package:wisata_app/bloc/search/search_state.dart';

import '../../repo/search_repository.dart';


class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository searchRepository;

  SearchBloc({required this.searchRepository}) : super(SearchInitial()) {
    on<SearchWisataEvent>((event, emit) async {
      emit(SearchLoading());

      try {
        final searchResponse = await searchRepository.searchObjekWisata(event.searchModel);
        emit(SearchLoaded(searchResponse.objekWisataList!));
      } catch (e) {
        emit(SearchError(e.toString()));
      }
    });
  }
}