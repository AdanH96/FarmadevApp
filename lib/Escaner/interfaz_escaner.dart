import 'package:farmadev/conexiones/consulta_apiCima.dart';
import 'package:farmadev/Escaner/texto_escaner.dart';
import 'package:flutter/material.dart';

//*CLASE DE PRUEBA ((IMPLEMENTAR BUSQUEDA POR CN, ESCRITO POR CAMPO. CASI TODOS LOS MEDICAMENTOS LO TRAEN))
//buscar otra manera de buscar el medicamento. Por via escaner es poco fiable.
//hay que buscar algun tipo de modulo por pyhton que sea atraves de fotos.

class Escaner extends StatefulWidget {
  const Escaner({super.key});

  @override
  State<Escaner> createState() => _EscanerState();
}

class _EscanerState extends State<Escaner> {
  String textoEscaneado = "Escanea un medicamento...";

  @override
  Widget build(BuildContext context) {
    //llamamos en constructor de buildcontext a textoEscaneado. Que devolverá un texto siempre.
    //Está a la espera de la función asyncrona para esperar a que el texto cambie

    return Scaffold(
        appBar: AppBar(
          title: const Text('Escaner de código de barras'),
        ),
        body: ListView(children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                String textoExtraido =
                    await TextRecognizerService().extraerBloquesTexto();

                setState(() {
                  textoEscaneado = textoExtraido;
                });
              },
              child: const Text('Escanear'),
            ),
          ),
          const SizedBox(height: 20),
          Center(
              child: Text(
            'El resultado es: $textoEscaneado',
            style: const TextStyle(fontSize: 16),
          ))
        ]));
  }
}
