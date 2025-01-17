import 'package:flutter/material.dart';
import 'package:farmadev/farmaco_datasource/farmaco_interfaz.dart';

class Medicamento extends StatelessWidget {
  final List<Farmaco> medicamentosObtenidos;
  final VoidCallback onBack;

  const Medicamento(
      {super.key, required this.medicamentosObtenidos, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicamentos encontrados'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack, // 🔄 Se resetea al regresar
        ),
      ),
      body: medicamentosObtenidos.isEmpty
          ? const Center(
              child: Text(
                "No se encontraron medicamentos",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          : PageView.builder(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemCount: medicamentosObtenidos.length,
              itemBuilder: (context, index) {
                Farmaco farmaco = medicamentosObtenidos[index];

                return SingleChildScrollView(
                  // 🔄 Permite hacer scroll dentro de cada medicamento
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            farmaco.imagenes.isNotEmpty
                                ? farmaco.imagenes[0]
                                : 'assets/images/imagen_por_defecto.png', // Usa imagen por defecto de assets
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          farmaco.nombre,
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          farmaco.labtitular,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        // Puedes agregar más información aquí y todo será desplazable
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
