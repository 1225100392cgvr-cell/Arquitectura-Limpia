import '../entities/lugar_turistico.dart';
import '../repositories/lugares_repository.dart';

// Caso de uso: "ver el detalle de un lugar".
class ObtenerLugarPorId {
  final LugaresRepository repository;
  ObtenerLugarPorId(this.repository);

  Future<LugarTuristico?> call(String id) => repository.obtenerPorId(id);
}
