import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:farmadev/farmaco_datasource/farmaco_interfaz.dart';

class Prospecto extends StatelessWidget {
  final int indice;
  final List<Farmaco> medicamentosObtenidos;
  final VoidCallback onBack;

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
          onPressed: onBack,
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

              //*TODO HAY QUE CAMBIAR ESTO POR INFORMACIÓN EXTENDIDA Y/O AVISAR DE CONSULTAR A UN MEDICO, A SER POSIBLE CON UN ICONO DE ASSETS O ALGO QUE TE ADVIERTA DE USO MEDICINAL
              if (farmaco.fichaTecnica.isNotEmpty)
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      final messenger = ScaffoldMessenger.of(context);
                      final url = farmaco.fichaTecnica;

                      if (url.isNotEmpty &&
                          Uri.tryParse(url)?.isAbsolute == true) {
                        final uri = Uri.parse(url);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri,
                              mode: LaunchMode.externalApplication);
                        } else {
                          await messenger.showSnackBar(
                            // Se añade await
                            const SnackBar(
                                content: Text('No se pudo abrir el enlace')),
                          );
                        }
                      } else {
                        await messenger.showSnackBar(
                          // Se añade await
                          const SnackBar(content: Text('URL no válida')),
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
