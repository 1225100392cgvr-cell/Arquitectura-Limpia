import 'package:flutter/material.dart';

// Imagen de asset con respaldo: si el archivo no existe muestra un ícono
// en lugar de romper la pantalla.
class ImagenLugar extends StatelessWidget {
  final String asset;
  final double? width;
  final double? height;

  const ImagenLugar({super.key, required this.asset, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stack) => Container(
        width: width,
        height: height,
        color: Colors.brown.shade100,
        child: const Icon(Icons.image_not_supported, color: Colors.brown),
      ),
    );
  }
}
