import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:farmadev/farmaco_datasource/farmaco_interfaz.dart';

class Prospecto extends StatelessWidget {
  final int indice;
  final List<Farmaco> medicamentosObtenidos;
  final VoidCallback onBack; // Agregamos la función para volver atrás

  const Prospecto(
      {super.key,
      required this.indice,
      required this.medicamentosObtenidos,
      required this.onBack});

  @override
  Widget build(BuildContext context) {
    final Farmaco farmaco = medicamentosObtenidos[indice];

    return Scaffold(
      appBar: AppBar(
        title: Text('Prospecto: ${farmaco.nombre}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack, // Permite regresar correctamente
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (farmaco.imagenes.isNotEmpty)
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      farmaco.imagenes[0],
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              Text(
                farmaco.nombre,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Laboratorio: ${farmaco.labtitular}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Requiere receta: ${farmaco.receta ? "Sí" : "No"}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Dosis: ${farmaco.dosis}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Principio activo: ${farmaco.vtm}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Vía de administración: ${farmaco.viasAdministracion}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Forma farmacéutica: ${farmaco.formaFarmaceutica}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              if (farmaco.docs.isNotEmpty)
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      final url = farmaco.docs[0]['url'];
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url),
                            mode: LaunchMode.externalApplication);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('No se pudo abrir el enlace')),
                        );
                      }
                    },
                    child: const Text('Ver ficha técnica'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
