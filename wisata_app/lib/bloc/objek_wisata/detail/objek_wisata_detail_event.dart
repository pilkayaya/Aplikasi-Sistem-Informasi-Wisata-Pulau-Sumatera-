part of 'objek_wisata_detail_bloc.dart';

@immutable
sealed class ObjekWisataDetailEvent {}

class GetObjekWisataDetailEvent extends ObjekWisataDetailEvent {
  final int id;

  GetObjekWisataDetailEvent(this.id);
}