//clase abstracta de la conexión para registrar y loggear como Usuario. (INTERFAZ)

abstract class DbCrearusuario {
  int? _idUsuario;
  String? _nombre;
  String? _email;
  String? _contrasena;

  int getIdUsuario() {
    return _idUsuario ?? 0;
  }

  String getNombreUsuario() {
    return _nombre ?? "default";
  }

  String getEmailUsuario() {
    return _email ?? "default";
  }

  String getContrasenaUsuario() {
    return _contrasena ?? "default";
  }

  Future signIn(String nombre, String email, String contrasena);
  Future logIn(String email, String contrasena);
  Future deleteAccount(String email, String contrasena);
  Future updateAccount(String email);
}
