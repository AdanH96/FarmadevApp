//TODO AQUI IMPLEMENTAR EL BUILDER DE MEDICAMENTOS CON UN STATEFULL WIDGET
import 'package:farmadev/Escaner/texto_escaner.dart';
import 'package:farmadev/conexiones/consulta_apiCima.dart';
import 'package:farmadev/farmaco_datasource/farmaco_interfaz.dart';
import 'package:flutter/material.dart';

//*ESTA CLASE VA A SER EL BUILDER DE MEDICAMENTOS A PARTIR DEL SCANNER
class Medicamento extends StatefulWidget {
  const Medicamento({super.key});

  @override
  State<Medicamento> createState() => _MedicamentoState();
}

class _MedicamentoState extends State<Medicamento> {
  List<Farmaco> medicamentosObtenidos = [];

  Future<List> construirMedicamentos() async {
    try {
      String query = await TextRecognizerService().extraerBloquesTexto();
      medicamentosObtenidos = await CimaApiService().buscarMedicamentos(query);
      return medicamentosObtenidos;
    } catch (e) {
      print("Error al extraer texto: $e");
      //en el caso de que quede vacio se retorna vacio
      return medicamentosObtenidos;
    }
  }

  @override
  Widget build(BuildContext context) {
    //aquí deberíamos implementar el lisviewBuilder para mostrar los medicamentos (MEDICAMENTOS OBTENIDOS ES UNA LISTA DE OBJETOS FARMACO)
    //RECORDAR QUE CUANDO SE TERMINE EL BUCLE DE GENERAR MEDICAMENTOS, SI LA LISTA ESTÁ VACÍA, SE DEBERÍA MOSTRAR UN WIDGET DE PLACEHOLDER
    //PARA INDICAR QUE NO SE ENCONTRARON MEDICAMENTOS CON UN CENTER TEXT O ALGO SIMILAR
    return const Placeholder();
  }
}
