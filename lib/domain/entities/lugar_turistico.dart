// DOMINIO: entidad pura. No importa Flutter ni paquetes externos.
class LugarTuristico {
  final String id;
  final String nombre;
  final String descripcion;
  final String imagenAsset; // ruta completa: assets/images/...
  final String audioAsset; // ruta SIN 'assets/' (AssetSource ya la asume)
  final String? videoAsset; // opcional: ruta completa assets/video/...

  const LugarTuristico({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.imagenAsset,
    required this.audioAsset,
    this.videoAsset,
  });
}
