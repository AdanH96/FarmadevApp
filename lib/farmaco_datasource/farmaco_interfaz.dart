class Farmaco {
  final String nombre;
  final String familia;
  final String dosis;
  final List<String> efectosAdversos;
  final String recomendaciones;
  final String laboratorio;

  // Constructor de la clase
  Farmaco({
    required this.nombre,
    required this.familia,
    required this.dosis,
    required this.efectosAdversos,
    required this.recomendaciones,
    required this.laboratorio,
  });

  String getNombre() {
    return nombre;
  }

  String getFamilia() {
    return familia;
  }

  String getDosis() {
    return dosis;
  }

  List getEfectosAdversos() {
    return efectosAdversos;
  }

  String getRecomendaciones() {
    return recomendaciones;
  }

  String getLaboratorio() {
    return laboratorio;
  }

  // Método para convertir un JSON a un objeto Farmaco
  factory Farmaco.fromJson(Map<String, dynamic> json) {
    return Farmaco(
      nombre: json['nombre'] ?? '',
      familia: json['familia'] ?? '',
      dosis: json['dosis'] ?? '',
      efectosAdversos: List<String>.from(json['efectos_adversos'] ?? []),
      recomendaciones: json['recomendaciones'] ?? '',
      laboratorio: json['laboratorio'] ?? '',
    );
  }

  // Método para convertir un objeto Farmaco a JSON
  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'familia': familia,
      'dosis': dosis,
      'efectos_adversos': efectosAdversos,
      'recomendaciones': recomendaciones,
      'laboratorio': laboratorio,
    };
  }

  @override
  String toString() {
    return 'Farmaco(nombre: $nombre, familia: $familia, dosis: $dosis, efectosAdversos: $efectosAdversos, recomendaciones: $recomendaciones, laboratorio: $laboratorio)';
  }
}
