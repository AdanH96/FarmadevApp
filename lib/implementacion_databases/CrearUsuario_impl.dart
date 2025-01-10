import 'package:farmadev/implementacion_databases/CrearDB_impl.dart';
import 'package:farmadev/interfaz_databases/db_crearUsuario.dart';

class CrearusuarioImpl extends DbCrearusuario {
  final CreardbImpl conexion = CreardbImpl();

  //esto se hace atraves de binding: (:nombre, :email, :contrasena). Esto es para evitar inyección de SQL
  //se sustituyen los valores ingresados mapeando los valores con los nombres de los parámetrosq

  //Método para crear un usuario
  @override
  Future<void> signIn(String nombre, String email, String contrasena) async {
    try {
      await conexion.crearConexion();
      if (conexion.conexionCreada) {
        await conexion.getConnection()?.execute(
          "INSERT INTO usuario (nombre, email, contrasena) VALUES (:nombre, :email, :contrasena)",
          {
            'nombre': nombre,
            'email': email,
            'contrasena': contrasena,
          },
        );
        print("Usuario creado con éxito.");
      } else {
        print("Error al crear usuario: Conexión no establecida.");
      }
    } catch (e) {
      print("Error al crear usuario: $e");
    } finally {
      if (conexion.conexionCreada) {
        await conexion.cerrarConexion();
      }
    }
  }

  //Método para loggear un usuario
  @override
  Future<void> logIn(String email, String contrasena) async {
    try {
      await conexion.crearConexion();
      if (!conexion.conexionCreada) {
        print("No se estableció conexión.");
        return;
      }

      var resultado = await conexion.getConnection()?.execute(
        "SELECT * FROM usuario WHERE email = :email AND contrasena = :contrasena",
        {
          'email': email,
          'contrasena': contrasena,
        },
      );

      if (resultado != null && resultado.rows.isNotEmpty) {
        print("Usuario loggeado con éxito.");
      } else {
        print("Error al loggear usuario: Credenciales incorrectas.");
      }
    } catch (e) {
      print("Error durante el inicio de sesión: $e");
    } finally {
      if (conexion.conexionCreada) {
        await conexion.cerrarConexion();
      }
    }
  }

  //Método para eliminar un usuario
  @override
  Future<void> deleteAccount(String email, String contrasena) async {
    try {
      await conexion.crearConexion();
      if (conexion.conexionCreada) {
        await conexion.getConnection()?.execute(
          "DELETE FROM usuario WHERE email = :email AND contrasena = :contrasena",
          {
            'email': email,
            'contrasena': contrasena,
          },
        );
        print("Usuario eliminado con éxito.");
      } else {
        print("Error al eliminar usuario: Conexión no establecida.");
      }
    } catch (e) {
      print("Error al eliminar usuario: $e");
    } finally {
      if (conexion.conexionCreada) {
        await conexion.cerrarConexion();
      }
    }
  }

  //Método para actualizar un usuario
  @override
  Future<void> updateAccount(String email) async {
    print("Función no implementada: updateAccount.");
    throw UnimplementedError(
        "El método updateAccount aún no está implementado.");
  }
}
