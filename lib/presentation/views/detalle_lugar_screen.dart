import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../domain/entities/lugar_turistico.dart';
import '../viewmodels/detalle_view_model.dart';
import 'widgets/imagen_lugar.dart';

class DetalleLugarScreen extends StatefulWidget {
  final LugarTuristico lugar;
  const DetalleLugarScreen({super.key, required this.lugar});

  @override
  State<DetalleLugarScreen> createState() => _DetalleLugarScreenState();
}

class _DetalleLugarScreenState extends State<DetalleLugarScreen> {
  late final DetalleViewModel _viewModel;
  VideoPlayerController? _video;
  bool _videoListo = false;

  @override
  void initState() {
    super.initState();
    _viewModel = DetalleViewModel(widget.lugar);

    final ruta = widget.lugar.videoAsset;
    if (ruta != null) {
      _video = VideoPlayerController.asset(ruta);
      _video!.initialize().then((_) {
        if (mounted) setState(() => _videoListo = true);
      }).catchError((_) {
        // Si el archivo no existe, simplemente no se muestra el video.
      });
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _video?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.lugar.nombre)),
      body: ListView(
        children: [
          ImagenLugar(
            asset: widget.lugar.imagenAsset,
            height: 220,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(widget.lugar.descripcion,
                style: const TextStyle(fontSize: 16)),
          ),
          AnimatedBuilder(
            animation: _viewModel,
            builder: (context, _) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: _viewModel.alternarAudio,
                    icon: Icon(_viewModel.reproduciendo
                        ? Icons.pause
                        : Icons.headphones),
                    label: Text(_viewModel.reproduciendo
                        ? 'Pausar audioguía'
                        : 'Escuchar audioguía'),
                  ),
                  if (_viewModel.errorAudio != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(_viewModel.errorAudio!,
                          style: const TextStyle(color: Colors.red)),
                    ),
                ],
              ),
            ),
          ),
          if (_videoListo)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: _video!.value.aspectRatio,
                    child: VideoPlayer(_video!),
                  ),
                  IconButton(
                    iconSize: 48,
                    icon: Icon(_video!.value.isPlaying
                        ? Icons.pause_circle
                        : Icons.play_circle),
                    onPressed: () {
                      setState(() {
                        _video!.value.isPlaying
                            ? _video!.pause()
                            : _video!.play();
                      });
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
