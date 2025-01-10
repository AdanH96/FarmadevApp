import 'package:mysql_client/mysql_client.dart';

// Clase para manejar la conexión con MySQL
class CreardbImpl {
  final String _direccionServidor = '10.0.2.2';
  final String _nombreDB = 'farmdevSQL';
  final int _puerto = 3306;
  final String _usuarioDB = 'farma';
  final String _contrasenaDB = '6164';

  // Variable para almacenar la conexión
  MySQLConnection? _connection;
  //bandera booleana para asegurar que la conexión está activa
  bool conexionCreada = false;

  // Método para crear conexión
  Future<void> crearConexion() async {
    try {
      //parámetros de conexión
      _connection = await MySQLConnection.createConnection(
        host: _direccionServidor,
        port: _puerto,
        userName: _usuarioDB,
        password: _contrasenaDB,
        databaseName: _nombreDB,
      );

      // Abrir la conexión
      await _connection!.connect();

      // Si no lanza excepción, la conexión fue exitosa
      conexionCreada = true;
      print("Conexión creada con éxito.");
    } catch (e) {
      // Si ocurre un error, marcar como fallida
      conexionCreada = false;
      print("Error al conectar a la base de datos: $e");
    }
  }

  // Método para obtener la conexión
  MySQLConnection? getConnection() {
    if (_connection == null || !conexionCreada) {
      print("Error: La conexión aún no está inicializada o activa.");
      return null;
    }
    return _connection;
  }

  // Método para cerrar la conexión
  Future<void> cerrarConexion() async {
    if (_connection != null && conexionCreada) {
      await _connection!.close();
      conexionCreada = false;
      print("Conexión cerrada.");
    } else {
      print("No hay conexión activa para cerrar.");
    }
  }
}
