// part of 'search_bloc.dart';
//
// class SearchEvent {
//   final String keyword;
//
//   SearchEvent(this.keyword);
// }


import '../../models/search_model.dart';

abstract class SearchEvent{
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchWisataEvent extends SearchEvent {
  final SearchModel searchModel;

  const SearchWisataEvent(this.searchModel);

  @override
  List<Object?> get props => [searchModel];
}

class LoadMoreSearchEvent extends SearchEvent {
  final int limit;

  LoadMoreSearchEvent(this.limit);
}
