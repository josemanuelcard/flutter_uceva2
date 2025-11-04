import 'package:flutter/material.dart';
import '../models/universidad.dart';
import '../services/universidad_service.dart';

class UniversidadFormScreen extends StatefulWidget {
  final Universidad? universidad;

  const UniversidadFormScreen({super.key, this.universidad});

  @override
  State<UniversidadFormScreen> createState() => _UniversidadFormScreenState();
}

class _UniversidadFormScreenState extends State<UniversidadFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final UniversidadService _universidadService = UniversidadService();

  late TextEditingController _nitController;
  late TextEditingController _nombreController;
  late TextEditingController _direccionController;
  late TextEditingController _telefonoController;
  late TextEditingController _paginaWebController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nitController = TextEditingController(text: widget.universidad?.nit ?? '');
    _nombreController =
        TextEditingController(text: widget.universidad?.nombre ?? '');
    _direccionController =
        TextEditingController(text: widget.universidad?.direccion ?? '');
    _telefonoController =
        TextEditingController(text: widget.universidad?.telefono ?? '');
    _paginaWebController =
        TextEditingController(text: widget.universidad?.paginaWeb ?? '');
  }

  @override
  void dispose() {
    _nitController.dispose();
    _nombreController.dispose();
    _direccionController.dispose();
    _telefonoController.dispose();
    _paginaWebController.dispose();
    super.dispose();
  }

  bool _esUrlValida(String url) {
    if (url.isEmpty) return true; // Permitir vacío si no es requerido
    final uri = Uri.tryParse(url);
    return uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.hasAuthority;
  }

  Future<void> _guardar() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final universidad = Universidad(
          id: widget.universidad?.id,
          nit: _nitController.text.trim(),
          nombre: _nombreController.text.trim(),
          direccion: _direccionController.text.trim(),
          telefono: _telefonoController.text.trim(),
          paginaWeb: _paginaWebController.text.trim(),
        );

        if (widget.universidad?.id != null) {
          // Actualizar
          await _universidadService.actualizarUniversidad(
              widget.universidad!.id!, universidad);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Universidad actualizada exitosamente'),
                backgroundColor: Colors.green,
              ),
            );
          }
        } else {
          // Crear
          await _universidadService.crearUniversidad(universidad);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Universidad creada exitosamente'),
                backgroundColor: Colors.green,
              ),
            );
          }
        }

        if (mounted) {
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.universidad != null
            ? 'Editar Universidad'
            : 'Nueva Universidad'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _nitController,
                      decoration: const InputDecoration(
                        labelText: 'NIT *',
                        hintText: 'Ej: 890.123.456-7',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.badge),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'El NIT es requerido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nombreController,
                      decoration: const InputDecoration(
                        labelText: 'Nombre *',
                        hintText: 'Ej: UCEVA',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.school),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'El nombre es requerido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _direccionController,
                      decoration: const InputDecoration(
                        labelText: 'Dirección *',
                        hintText: 'Ej: Cra 27A #48-144, Tuluá - Valle',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.location_on),
                      ),
                      maxLines: 2,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'La dirección es requerida';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _telefonoController,
                      decoration: const InputDecoration(
                        labelText: 'Teléfono *',
                        hintText: 'Ej: +57 602 2242202',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'El teléfono es requerido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _paginaWebController,
                      decoration: const InputDecoration(
                        labelText: 'Página Web *',
                        hintText: 'Ej: https://www.uceva.edu.co',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.language),
                      ),
                      keyboardType: TextInputType.url,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'La página web es requerida';
                        }
                        if (!_esUrlValida(value.trim())) {
                          return 'Ingrese una URL válida (http:// o https://)';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _guardar,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        widget.universidad != null
                            ? 'Actualizar Universidad'
                            : 'Crear Universidad',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

