import 'package:flutter/material.dart';
import 'package:farmadev/Escaner/texto_escaner.dart';
import 'package:farmadev/conexiones/consulta_apiCima.dart';
import 'package:farmadev/farmaco_datasource/farmaco_interfaz.dart';
import 'package:farmadev/interfaz_app/interfaz_builder_medicamento.dart'; // Se importa Medicamento.dart

class Escaner extends StatefulWidget {
  const Escaner({super.key});

  @override
  State<Escaner> createState() => _EscanerState();
}

class _EscanerState extends State<Escaner> {
  String textoEscaneado = "Escanea un medicamento...";
  List<Farmaco> medicamentosObtenidos = [];
  bool isLoading = false;
  bool escaneoRealizado = false;

  Future<void> escanearMedicamento() async {
    setState(() {
      isLoading = true;
      escaneoRealizado = true;
      textoEscaneado = "Escaneando...";
    });

    try {
      // Extraer texto de la imagen
      String query = await TextRecognizerService().extraerBloquesTexto();
      print('Texto escaneado: $query');

      if (query.isEmpty) {
        throw Exception("No se detectó texto en la imagen.");
      }

      // Consultar API de medicamentos
      List<Farmaco> resultado =
          await CimaApiService().buscarMedicamentos(query);

      // 🔄 Solo actualiza el estado después de completar la consulta
      if (mounted) {
        setState(() {
          textoEscaneado = resultado.isNotEmpty
              ? "Se han encontrado medicamentos:"
              : "No se encontraron medicamentos.";
          medicamentosObtenidos = resultado;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          textoEscaneado = "Error al escanear: $e";
          isLoading = false;
        });
      }
      print("Error al extraer texto: $e");
    }
  }

  void resetEscaner() {
    setState(() {
      escaneoRealizado = false;
      medicamentosObtenidos.clear();
      textoEscaneado = "Escanea un medicamento...";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Escanee un medicamento')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : escaneoRealizado
              ? Medicamento(
                  medicamentosObtenidos: medicamentosObtenidos,
                  onBack: resetEscaner, // 🔄 Se limpia todo al regresar
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: ElevatedButton(
                        onPressed: escanearMedicamento,
                        child: const Text('Escanear'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        textoEscaneado,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
    );
  }
}
