class Farmaco {
  final String nombre;
  final String labtitular;
  final String labcomercializador;
  final String cpresc;
  final bool receta;
  final bool generico;
  final bool conduc;
  final bool triangulo;
  final bool huerfano;
  final bool biosimilar;
  final String nosustituible;
  final bool psum;
  final bool auto;
  final List<String> imagenes;

  // Constructor de la clase
  Farmaco({
    required this.nombre,
    required this.labtitular,
    required this.labcomercializador,
    required this.cpresc,
    required this.receta,
    required this.generico,
    required this.conduc,
    required this.triangulo,
    required this.huerfano,
    required this.biosimilar,
    required this.nosustituible,
    required this.psum,
    required this.auto,
    required this.imagenes,
  });

  // Método para convertir un JSON a un objeto Farmaco (espera un elemento de la lista 'resultados')
  factory Farmaco.fromJson(Map<String, dynamic> json) {
    return Farmaco(
      nombre: json['nombre'] ?? '',
      labtitular: json['labtitular'] ?? '',
      labcomercializador: json['labcomercializador'] ?? '',
      cpresc: json['cpresc'] ?? '',
      receta: json['receta'] ?? false,
      generico: json['generico'] ?? false,
      conduc: json['conduc'] ?? false,
      triangulo: json['triangulo'] ?? false,
      huerfano: json['huerfano'] ?? false,
      biosimilar: json['biosimilar'] ?? false,
      nosustituible: json['nosustituible']?['nombre'] ?? 'N/A',
      psum: json['psum'] ?? false,
      auto: json['estado']?['aut'] ?? false,
      //para poder usar esto hay que utilizar el metodo de image.fromlink de flutter y apuntar sobre farmaco.imagenes
      imagenes: json['fotos'] != null && json['fotos'].isNotEmpty
          ? [json['fotos'][0]['url'] as String] // Extrae solo el primer link
          : [], // Si no hay fotos, devuelve una lista vacía
    );
  }

  // Método para convertir un JSON con 'resultados' a una lista de Farmacos
  static List<Farmaco> fromJsonList(Map<String, dynamic> json) {
    List<dynamic> resultados = json['resultados'] ?? [];
    return resultados.map((item) => Farmaco.fromJson(item)).toList();
  }

  @override
  String toString() {
    return 'Farmaco(nombre: $nombre, labtitular: $labtitular, labcomercializador: $labcomercializador, cpresc: $cpresc, receta: $receta, generico: $generico, conduc: $conduc, triangulo: $triangulo, huerfano: $huerfano, biosimilar: $biosimilar, nosustituible: $nosustituible, psum: $psum, auto: $auto, imagenes: $imagenes)';
  }
}
