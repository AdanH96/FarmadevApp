import 'dart:convert';
import 'package:farmadev/Escaner/texto_escaner.dart';
import 'package:http/http.dart' as http;

class CimaApiService {
  final String baseUrl = 'https://cima.aemps.es/cima/rest/medicamentos';

  Future<List<dynamic>> buscarMedicamentos(String query) async {
    final url = Uri.parse('$baseUrl?nombre=$query');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['resultados']; // Devuelve la lista de resultados
      } else {
        throw Exception('Error en la consulta: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al consultar la API: $e');
    }
  }

//ESTO ES UNA PRUEBA
  void pruebaCima() async {
    try {
      String texto = await TextRecognizerService().extraerBloquesTexto();
      List medicamentosObtenidos = await buscarMedicamentos(texto);

      for (int i = 0; i < medicamentosObtenidos.length; i++) {
        print(medicamentosObtenidos[i]['nombre']);
      }
      for (int i = 0; i < medicamentosObtenidos.length; i++) {
        print(
            'Nombre: ${medicamentosObtenidos[i]['nombre']}, Laboratorio: ${medicamentosObtenidos[i]['laboratorio']}');
      }
    } catch (e) {
      print("Error al extraer texto: $e");
    }
  }
}
