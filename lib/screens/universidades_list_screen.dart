import 'package:flutter/material.dart';
import '../models/universidad.dart';
import '../services/universidad_service.dart';
import 'universidad_form_screen.dart';

class UniversidadesListScreen extends StatelessWidget {
  const UniversidadesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UniversidadService universidadService = UniversidadService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Universidades'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: StreamBuilder<List<Universidad>>(
        stream: universidadService.obtenerUniversidadesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    const Text(
                      'Error al conectar con Firebase',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${snapshot.error}',
                      style: const TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Forzar reconstrucción
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const UniversidadesListScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reintentar'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.school_outlined,
                      size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'No hay universidades registradas',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Toca el botón + para agregar una',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          final universidades = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: universidades.length,
            itemBuilder: (context, index) {
              final universidad = universidades[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                elevation: 2,
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.school),
                  ),
                  title: Text(
                    universidad.nombre,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text('NIT: ${universidad.nit}'),
                      Text('Dirección: ${universidad.direccion}'),
                      Text('Teléfono: ${universidad.telefono}'),
                      if (universidad.paginaWeb.isNotEmpty)
                        Text(
                          'Web: ${universidad.paginaWeb}',
                          style: const TextStyle(color: Colors.blue),
                        ),
                    ],
                  ),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UniversidadFormScreen(
                                universidad: universidad,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _mostrarDialogoEliminar(context, universidad);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UniversidadFormScreen(),
            ),
          );
        },
        tooltip: 'Agregar Universidad',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _mostrarDialogoEliminar(
      BuildContext context, Universidad universidad) {
    final UniversidadService universidadService = UniversidadService();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirmar eliminación'),
          content: Text(
              '¿Estás seguro de eliminar la universidad "${universidad.nombre}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  if (universidad.id != null) {
                    await universidadService.eliminarUniversidad(universidad.id!);
                    if (context.mounted) {
                      Navigator.of(dialogContext).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Universidad eliminada exitosamente'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  }
                } catch (e) {
                  if (context.mounted) {
                    Navigator.of(dialogContext).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error al eliminar: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}

