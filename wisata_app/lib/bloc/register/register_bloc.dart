import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wisata_app/params/register_param.dart';

import '../../core/api_exception.dart';
import '../../repo/register_repository.dart';
import '../../response/register_response.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository registerRepository;

  RegisterBloc({required this.registerRepository}) : super(RegisterInitial()) {
    on<RegisterPressed>((event, emit) async {
      emit(RegisterLoading());
      try {
        final registerResponse = await registerRepository.register(event.registerParam);
        emit(RegisterSuccess(registerResponse: registerResponse));
      } catch (error) {
        if (error is ApiException) {
          emit(RegisterError(message: error.message));
        } else {
          emit(RegisterError(message: error.toString()));
        }
      }
    });
  }
}
