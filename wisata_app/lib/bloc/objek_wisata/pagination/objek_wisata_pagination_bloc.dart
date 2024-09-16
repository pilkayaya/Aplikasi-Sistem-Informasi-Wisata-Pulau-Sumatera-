import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wisata_app/models/objek_wisata_model.dart';
import 'package:wisata_app/repo/objek_wisata_repository.dart';

part 'objek_wisata_pagination_event.dart';
part 'objek_wisata_pagination_state.dart';

class ObjekWisataPaginationBloc extends Bloc<ObjekWisataPaginationEvent, ObjekWisataPaginationState> {
  final ObjekWisataRepository objekWisataRepository;

  ObjekWisataPaginationBloc({required this.objekWisataRepository}) : super(ObjekWisataPaginationInitial()) {
    on<ObjekWisataPaginationEvent>((event, emit) async {
      try {
        if (state is ObjekWisataPaginationInitial) {
          List<ObjekWisataModel> list = await objekWisataRepository.getPaginationObjekWisata(8, 0);
          emit(ObjekWisataPaginationLoaded(listObjekWisataModel: list));
        } else if (state is ObjekWisataPaginationLoaded) {
          ObjekWisataPaginationLoaded objekWisataPaginationLoaded = state as ObjekWisataPaginationLoaded;
          List<ObjekWisataModel> list = await objekWisataRepository.getPaginationObjekWisata(
              8, objekWisataPaginationLoaded.listObjekWisataModel.length);
          emit(list.isEmpty
              ? objekWisataPaginationLoaded.copyWith(hasReachedMax: true)
              : objekWisataPaginationLoaded.copyWith(
              list: objekWisataPaginationLoaded.listObjekWisataModel + list));
        }
      } catch (e) {
        emit(ObjekWisataPaginationError(message: e.toString()));
      }
    });
  }
}
