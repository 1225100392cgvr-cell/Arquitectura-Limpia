// Pruebas del DOMINIO con un Fake: sin Flutter, sin audio, sin video.
import 'package:flutter_test/flutter_test.dart';
import 'package:descubre/domain/entities/lugar_turistico.dart';
import 'package:descubre/domain/repositories/lugares_repository.dart';
import 'package:descubre/domain/usecases/obtener_lugares.dart';
import 'package:descubre/domain/usecases/obtener_lugar_por_id.dart';

const _lugarPrueba = LugarTuristico(
  id: '1',
  nombre: 'Lugar de prueba',
  descripcion: 'Descripcion de prueba',
  imagenAsset: 'x.jpg',
  audioAsset: 'x.mp3',
);

class FakeLugaresRepository implements LugaresRepository {
  @override
  Future<List<LugarTuristico>> obtenerTodos() async => const [_lugarPrueba];

  @override
  Future<LugarTuristico?> obtenerPorId(String id) async =>
      id == '1' ? _lugarPrueba : null;
}

void main() {
  test('ObtenerLugares regresa la lista que entrega el repositorio', () async {
    final usecase = ObtenerLugares(FakeLugaresRepository());
    final resultado = await usecase();

    expect(resultado.length, 1);
    expect(resultado.first.nombre, 'Lugar de prueba');
  });

  test('ObtenerLugarPorId regresa el lugar cuando el id existe', () async {
    final usecase = ObtenerLugarPorId(FakeLugaresRepository());
    final lugar = await usecase('1');

    expect(lugar, isNotNull);
    expect(lugar!.id, '1');
  });

  test('ObtenerLugarPorId regresa null cuando el id no existe', () async {
    final usecase = ObtenerLugarPorId(FakeLugaresRepository());

    expect(await usecase('999'), isNull);
  });
}
