part of 'search_coba_bloc.dart';

enum SearchType {
  nama,
  kategoriProvinsi,
  kategoriObjekWisata,
}
abstract class SearchingEvent {
  const SearchingEvent();
}

class GetSearchEvent extends SearchingEvent {
  final String query;
  final int limit; // Add limit attribute
  final int offset; // Add offset attribute
  final SearchType searchType;

  GetSearchEvent({
    required this.query,
    required this.limit,
    required this.offset,
    required this.searchType,
  });

  @override
  List<Object?> get props => [query, limit, offset, searchType];
}
