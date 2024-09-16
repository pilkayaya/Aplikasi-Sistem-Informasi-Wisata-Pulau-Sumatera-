part of 'objek_wisata_detail_bloc.dart';

@immutable
sealed class ObjekWisataDetailState {}

final class ObjekWisataDetailInitial extends ObjekWisataDetailState {}

final class ObjekWisataDetailLoading extends ObjekWisataDetailState {}

class ObjekWisataDetailLoaded extends ObjekWisataDetailState {
  final ObjekWisataModel objekWisata;

  ObjekWisataDetailLoaded(this.objekWisata);
}

class ObjekWisataDetailError extends ObjekWisataDetailState {
  final String message;

  ObjekWisataDetailError(this.message);
}
