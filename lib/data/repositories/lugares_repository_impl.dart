// DATOS: implementa el contrato del dominio.
import '../../domain/entities/lugar_turistico.dart';
import '../../domain/repositories/lugares_repository.dart';
import '../datasources/lugares_local_datasource.dart';

class LugaresRepositoryImpl implements LugaresRepository {
  final LugaresLocalDataSource dataSource;
  LugaresRepositoryImpl(this.dataSource);

  @override
  Future<List<LugarTuristico>> obtenerTodos() async =>
      dataSource.obtenerLugares();

  @override
  Future<LugarTuristico?> obtenerPorId(String id) async {
    for (final lugar in dataSource.obtenerLugares()) {
      if (lugar.id == id) return lugar;
    }
    return null;
  }
}
