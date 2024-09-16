// File: search_bloc.dart

import 'package:wisata_app/models/objek_wisata_model.dart';

abstract class SearchState {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<ObjekWisataModel> objekWisataList;

  const SearchLoaded(this.objekWisataList);

  @override
  List<Object?> get props => [objekWisataList];
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object?> get props => [message];
}


