import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wisata_app/core/session_manager.dart';

part 'setting_app_state.dart';

class SettingAppCubit extends Cubit<SettingAppState> {
  final sessionManager = SessionManager();
  SettingAppCubit() : super(SettingAppInitial()){
    checkSession();
  }

  void checkSession() {
    final activeSession = sessionManager.activeSession();
    if(activeSession){
      emit(SettingAppAuthenticated());
    }else {
      emit(SettingAppUnAuthenticated());
    }
  }

  void signOut() {
    sessionManager.signOut();
    emit(SettingAppUnAuthenticated());
  }
}
