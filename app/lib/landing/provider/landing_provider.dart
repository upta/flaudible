import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flaudible/data/mock.dart';

final currentlyPlayingProvider = Provider((ref) => continueListening[0]);
