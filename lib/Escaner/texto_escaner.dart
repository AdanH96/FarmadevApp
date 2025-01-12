import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class TextRecognizerService {
  final ImagePicker _imagePicker = ImagePicker();
  String textoReconocido = "";

  /// Función para capturar una imagen desde la cámara y reconocer texto.

  Future<String> procesarImagen(XFile imagen) async {
    final InputImage inputImage = InputImage.fromFilePath(imagen.path);
    final TextRecognizer textRecognizer = TextRecognizer();

    try {
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);

      String mayorTexto = "";
      double mayorTamanio = 0;

      // Iterar sobre los bloques y líneas para encontrar el texto más grande
      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          // Obtener el tamaño de la línea desde su bounding box
          double tamanioFuente = line.boundingBox.height;

          if (tamanioFuente > mayorTamanio) {
            mayorTamanio = tamanioFuente;
            mayorTexto = line.text;
          }
        }
      }

      textRecognizer.close();
      return mayorTexto; // Devuelve el texto con mayor tamaño de fuente
    } catch (e) {
      textRecognizer.close();
      return "Error al procesar la imagen: $e";
    }
  }

  Future<String> extraerBloquesTexto() async {
    try {
      final XFile? image =
          await _imagePicker.pickImage(source: ImageSource.camera);
      if (image == null) {
        return "No se capturó ninguna imagen.";
      } else {
        String resultadoTexto = await procesarImagen(image);
        return resultadoTexto;
      }
    } catch (e) {
      return "Error al reconocer el texto: $e";
    }
  }
}
