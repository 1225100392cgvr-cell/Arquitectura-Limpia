import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import '../../domain/entities/lugar_turistico.dart';

class DetalleViewModel extends ChangeNotifier {
  final LugarTuristico lugar;
  final AudioPlayer _reproductor = AudioPlayer();
  late final StreamSubscription<void> _alTerminar;

  bool reproduciendo = false;
  bool _iniciado = false; // ya se cargó el audio al menos una vez
  String? errorAudio;

  DetalleViewModel(this.lugar) {
    // Cuando termina la narración, el botón vuelve a "Escuchar".
    _alTerminar = _reproductor.onPlayerComplete.listen((_) {
      reproduciendo = false;
      _iniciado = false;
      notifyListeners();
    });
  }

  Future<void> alternarAudio() async {
    try {
      errorAudio = null;
      if (reproduciendo) {
        await _reproductor.pause();
        reproduciendo = false;
      } else {
        if (_iniciado) {
          await _reproductor.resume(); // continúa donde se pausó
        } else {
          await _reproductor.play(AssetSource(lugar.audioAsset));
          _iniciado = true;
        }
        reproduciendo = true;
      }
    } catch (_) {
      reproduciendo = false;
      errorAudio = 'No se pudo reproducir la audioguía.';
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _alTerminar.cancel();
    _reproductor.dispose();
    super.dispose();
  }
}
