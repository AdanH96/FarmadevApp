import 'package:farmadev/Escaner/texto_escaner.dart';

class Medicamento {
  String? nombreMedicamento;
  String? laboratorio;
  String? principioActivo;
  String? tipoAdministracion;
  String? codigoNacional;
  String? informaciomAdicional;

  Medicamento(
      {this.nombreMedicamento,
      this.laboratorio,
      this.principioActivo,
      this.tipoAdministracion,
      this.codigoNacional,
      this.informaciomAdicional});

  Future generarTexto() async {
    String textoObtenido =
        await TextRecognizerService().recognizeTextFromCamera();
    //esto llama a la cámara y devuelve el texto que se ha escaneado

    //TODO IMPLEMENTAR LA BUSQUEDA DEL MEDICAMENTO POR LA QUERY DE LA BASE DE DATOS
  }
}
