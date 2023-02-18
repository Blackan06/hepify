import 'package:video_player/video_player.dart';

class Exercise {
  final String name;
  final Duration duration;
  final int noOfReps;
  final String videoUrl;
  final double calo;
  VideoPlayerController? controller;

  Exercise({
    required this.name,
    required this.duration,
    required this.noOfReps,
    required this.videoUrl,
    required this.calo,
  });
}
