part of 'search_coba_bloc.dart';

abstract class SearchCobaState {}

class SearchingInitial extends SearchCobaState {}

class SearchingLoading extends SearchCobaState {}

class SearchingLoaded extends SearchCobaState {
  final List<dynamic> results;

  SearchingLoaded({required this.results});
}

class SearchingError extends SearchCobaState {}