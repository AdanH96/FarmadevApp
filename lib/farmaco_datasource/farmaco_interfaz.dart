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
  final String dosis;
  final String vtm;
  final String viasAdministracion;
  final String formaFarmaceutica;
  final String nosustituible;
  final bool psum;
  final int auto; // Estado["aut"] ahora se almacena como int (timestamp)
  final String fichaTecnica;
  final List<String> imagenes;

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
    required this.dosis,
    required this.vtm,
    required this.viasAdministracion,
    required this.formaFarmaceutica,
    required this.nosustituible,
    required this.psum,
    required this.auto,
    required this.fichaTecnica,
    required this.imagenes,
  });

  factory Farmaco.fromJson(Map<String, dynamic> json) {
    // Función para obtener la primera URL válida de `docs`
    String getFirstValidDocUrl(List<dynamic>? docs) {
      if (docs != null && docs.isNotEmpty) {
        for (var doc in docs) {
          if (doc['url'] != null && doc['url'].toString().isNotEmpty) {
            return doc['url'].toString();
          }
        }
      }
      return ''; // Retornar string vacío si no hay una URL válida
    }

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
      dosis: json['dosis'] ?? 'A consultar',
      vtm: json['vtm']?['nombre'] ?? 'No disponible',
      viasAdministracion: json['viasAdministracion'] != null &&
              json['viasAdministracion'].isNotEmpty
          ? json['viasAdministracion'][0]['nombre'] ?? 'No especificada'
          : 'No especificada',
      formaFarmaceutica:
          json['formaFarmaceutica']?['nombre'] ?? 'No disponible',
      nosustituible: json['nosustituible']?['nombre'] ?? 'N/A',
      psum: json['psum'] ?? false,
      auto: json["estado"]?["aut"] ??
          0, // Aseguramos que siempre tenga un valor numérico válido
      fichaTecnica: getFirstValidDocUrl(json['docs']),
      imagenes: json['fotos'] != null && json['fotos'].isNotEmpty
          //ESTO AL IGUAL HAY QUE CAMBIARLO.
          ? [json['fotos'][0]['url'] as String] // Extrae solo la primera imagen
          : [],
    );
  }
}
