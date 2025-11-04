import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/universidad.dart';

class UniversidadService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'universidades';

  // Crear una nueva universidad
  Future<String> crearUniversidad(Universidad universidad) async {
    try {
      final docRef = await _firestore
          .collection(_collectionName)
          .add(universidad.toFirestore());
      return docRef.id;
    } catch (e) {
      throw Exception('Error al crear universidad: $e');
    }
  }

  // Obtener stream en tiempo real de todas las universidades
  Stream<List<Universidad>> obtenerUniversidadesStream() {
    return _firestore
        .collection(_collectionName)
        .orderBy('nombre')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Universidad.fromFirestore(
              doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }

  // Obtener una universidad por ID
  Future<Universidad?> obtenerUniversidadPorId(String id) async {
    try {
      final doc = await _firestore.collection(_collectionName).doc(id).get();
      if (doc.exists) {
        return Universidad.fromFirestore(
            doc.data()! as Map<String, dynamic>, doc.id);
      }
      return null;
    } catch (e) {
      throw Exception('Error al obtener universidad: $e');
    }
  }

  // Actualizar una universidad
  Future<void> actualizarUniversidad(
      String id, Universidad universidad) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(id)
          .update(universidad.toFirestore());
    } catch (e) {
      throw Exception('Error al actualizar universidad: $e');
    }
  }

  // Eliminar una universidad
  Future<void> eliminarUniversidad(String id) async {
    try {
      await _firestore.collection(_collectionName).doc(id).delete();
    } catch (e) {
      throw Exception('Error al eliminar universidad: $e');
    }
  }
}

