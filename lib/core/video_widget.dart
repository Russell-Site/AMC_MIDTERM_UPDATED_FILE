import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final String url;
  const VideoWidget({super.key, required this.url});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        setState(() => _isInitialized = true);
        _controller.setLooping(true);
        _controller.setVolume(0);
        _controller.play(); // Auto-play on start
      });

    // ADD THIS: This tells the widget to rebuild whenever the video state changes
    _controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    // It's extra important to remove listeners before disposing
    _controller.removeListener(() {});
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Container(
          height: 250,
          color: Colors.white10,
          child: const Center(child: CircularProgressIndicator())
      );
    }

    return GestureDetector(
      onTap: () {
        // Toggle play/pause
        if (_controller.value.isPlaying) {
          _controller.pause();
        } else {
          _controller.play();
        }
        // setState is called automatically now because of the Listener in initState
      },
      child: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: Stack(
          alignment: Alignment.center,
          children: [
            VideoPlayer(_controller),

            // This now disappears/appears correctly
            if (!_controller.value.isPlaying)
              IgnorePointer( // Prevents the icon from blocking the tap
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.black45,
                  child: Icon(Icons.play_arrow, color: Colors.white, size: 40),
                ),
              ),
          ],
        ),
      ),
    );
  }
}