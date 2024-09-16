import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/objek_wisata_model.dart';
import '../../../repo/objek_wisata_repository.dart';

part 'objek_wisata_detail_event.dart';
part 'objek_wisata_detail_state.dart';

class ObjekWisataDetailBloc extends Bloc<ObjekWisataDetailEvent, ObjekWisataDetailState> {
  final ObjekWisataRepository objekWisataRepository;

  ObjekWisataDetailBloc(this.objekWisataRepository)
      : super(ObjekWisataDetailInitial()) {
    on<GetObjekWisataDetailEvent>((event, emit) async {
      emit(ObjekWisataDetailLoading());
      try {
        final objekWisata =
            await objekWisataRepository.getObjekWisataDetail(event.id);
        emit(ObjekWisataDetailLoaded(objekWisata));
      } catch (e) {
        emit(ObjekWisataDetailError(e.toString()));
      }
    });
  }
}
