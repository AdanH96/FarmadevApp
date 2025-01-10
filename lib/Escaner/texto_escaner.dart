import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class TextRecognizerService {
  final ImagePicker _imagePicker = ImagePicker();
  String textoReconocido = "";

  /// Función para capturar una imagen desde la cámara y reconocer texto.
  Future<String> recognizeTextFromCamera() async {
    try {
      // Capturar una imagen desde la cámara
      final XFile? image =
          await _imagePicker.pickImage(source: ImageSource.camera);
      if (image == null) return "No se capturó ninguna imagen.";

      // Crear un InputImage a partir del archivo capturado
      final InputImage inputImage = InputImage.fromFilePath(image.path);

      // Inicializar el TextRecognizer
      final TextRecognizer textRecognizer = TextRecognizer();

      // Procesar la imagen
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);

      // Cerrar el recognizer
      textRecognizer.close();

      // Devolver el texto reconocido
      if (recognizedText.text.isNotEmpty) {
        textoReconocido = recognizedText.text;
        return recognizedText.text;
      } else {
        return "No se ha reconocido ningún texto";
      }
    } catch (e) {
      return "Error al reconocer el texto: $e";
    }
  }
}
