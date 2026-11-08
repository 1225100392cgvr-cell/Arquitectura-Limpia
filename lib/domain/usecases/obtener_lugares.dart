import '../entities/lugar_turistico.dart';
import '../repositories/lugares_repository.dart';

// Caso de uso: "ver la lista de lugares".
class ObtenerLugares {
  final LugaresRepository repository;
  ObtenerLugares(this.repository);

  Future<List<LugarTuristico>> call() => repository.obtenerTodos();
}
