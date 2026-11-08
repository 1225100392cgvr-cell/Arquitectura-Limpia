// DOMINIO: contrato. Define QUÉ se necesita, no CÓMO se obtiene.
import '../entities/lugar_turistico.dart';

abstract class LugaresRepository {
  Future<List<LugarTuristico>> obtenerTodos();
  Future<LugarTuristico?> obtenerPorId(String id);
}
