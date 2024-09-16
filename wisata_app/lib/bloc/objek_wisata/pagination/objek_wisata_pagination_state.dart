part of 'objek_wisata_pagination_bloc.dart';

@immutable
sealed class ObjekWisataPaginationState {}

final class ObjekWisataPaginationInitial extends ObjekWisataPaginationState {}

final class ObjekWisataPaginationLoading extends ObjekWisataPaginationState {}

final class ObjekWisataPaginationLoaded extends ObjekWisataPaginationState {
  final List<ObjekWisataModel> listObjekWisataModel;
  final bool hasReachedMax;
  ObjekWisataPaginationLoaded(
      {this.listObjekWisataModel = const <ObjekWisataModel>[],
      this.hasReachedMax = false});
  ObjekWisataPaginationLoaded copyWith(
      {List<ObjekWisataModel>? list, bool? hasReachedMax}) {
    return ObjekWisataPaginationLoaded(
        listObjekWisataModel: list ?? this.listObjekWisataModel,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }
}

final class ObjekWisataPaginationError extends ObjekWisataPaginationState {
  final String message;
  ObjekWisataPaginationError({required this.message});
}
