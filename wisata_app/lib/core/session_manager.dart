import 'package:hive/hive.dart';

class SessionManager {
  final Box box = Hive.box('session');

  void setSession(String token, int id, String firstName, String lastName,
      String email, bool isActive, bool isPengguna, String foto) {
    box.put(AppKey.tokenKey, token);
    box.put(AppKey.idKey, id);
    box.put(AppKey.firstNameKey, firstName);
    box.put(AppKey.lastNameKey, lastName);
    box.put(AppKey.emailKey, email);
    box.put(AppKey.isActiveKey, isActive);
    box.put(AppKey.isPenggunaKey, isPengguna);
    box.put(AppKey.fotoKey, foto);

  }

  String? getActiveToken() => box.get(AppKey.tokenKey);
  int? getActiveId() => box.get(AppKey.idKey);
  String? getActiveFirstname() => box.get(AppKey.firstNameKey);
  String? getActiveLastname() => box.get(AppKey.lastNameKey);
  String? getActiveEmail() => box.get(AppKey.emailKey);
  bool? getActiveIsActive() => box.get(AppKey.isActiveKey);
  bool? getActiveIsPengguna() => box.get(AppKey.isPenggunaKey);
  String? getActiveFoto() => box.get(AppKey.fotoKey);


  bool activeSession() {
    String? activeToken = getActiveToken();
    int? activeId = getActiveId();
    String? activeFirstname = getActiveFirstname();
    String? activeLastname = getActiveLastname();
    String? activeEmail = getActiveEmail();
    bool? activeIsActive = getActiveIsActive();
    bool? activeIsPengguna = getActiveIsPengguna();
    String? activeFoto = getActiveFoto();

    return activeToken != null &&
        activeId != null &&
        activeFirstname != null &&
        activeLastname != null &&
        activeEmail != null &&
        activeIsActive != null &&
        activeIsPengguna != null &&
        activeFoto != null;

  }

  void signOut() {
    print('Signing out...');
    box.delete(AppKey.tokenKey);
    box.delete(AppKey.idKey);
    box.delete(AppKey.firstNameKey);
    box.delete(AppKey.lastNameKey);
    box.delete(AppKey.emailKey);
    box.delete(AppKey.isActiveKey);
    box.delete(AppKey.isPenggunaKey);
    box.delete(AppKey.fotoKey);

  }
}

class AppKey {
  static const String tokenKey = 'TOKEN_KEY';
  static const String idKey = 'ID_KEY';
  static const String firstNameKey = 'FIRST_NAME_KEY';
  static const String lastNameKey = 'LAST_NAME_KEY';
  static const String emailKey = 'EMAIL_KEY';
  static const String isActiveKey = 'IS_ACTIVE_KEY';
  static const String isPenggunaKey = 'IS_PENGGUNA_KEY';
  static const String fotoKey = 'FOTO_KEY';

}
