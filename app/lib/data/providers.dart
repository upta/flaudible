import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/data/mock.dart';

final continueListeningProvider = Provider((ref) => continueListening);
final becauseYouListenedProvider = Provider((ref) => becauseYouListened);
final audibleOriginalsProvider = Provider((ref) => audibleOriginals);
final currentlyPlayingProvider = Provider((ref) => continueListening[0]);
