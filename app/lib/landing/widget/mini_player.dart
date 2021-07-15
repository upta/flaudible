import 'package:flaudible/data/audible_icons_icons.dart';
import 'package:flaudible/landing/provider/landing_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:marquee/marquee.dart';

class MiniPlayer extends HookConsumerWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final book = ref.watch(currentlyPlayingProvider);
    final diff = book.length - book.played;

    final remaining = diff.inHours > 0
        ? '${diff.inHours}h ${diff.inMinutes % 60}m'
        : '${diff.inMinutes % 60}m';

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      ),
      padding: const EdgeInsets.only(
        top: 11.0,
        right: 15.0,
        bottom: 11.0,
        left: 11.0,
      ),
      child: Row(
        children: [
          FadeInImage.assetNetwork(
            width: 48.0,
            placeholder: 'assets/loading.png',
            image: book.image,
          ),
          SizedBox(
            width: 11.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      colors: [
                        Theme.of(context).textTheme.bodyText1!.color!,
                        Colors.transparent,
                      ],
                      stops: [
                        0.9,
                        1.0,
                      ],
                    ).createShader(rect);
                  },
                  child: SizedBox(
                    height: 20.0,
                    child: Marquee(
                      text: '${book.title} | ${book.currentChapter}',
                      crossAxisAlignment: CrossAxisAlignment.start,
                      blankSpace: 50.0,
                      pauseAfterRound: Duration(
                        seconds: 3,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 2.0,
                    top: 1.0,
                  ),
                  child: Text(
                    '$remaining left',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          fontSize: 11.0,
                        ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 28.0,
          ),
          Icon(
            AudibleIcons.back30,
            size: 31.0,
            color: Colors.grey.shade400,
          ),
          SizedBox(
            width: 17.0,
          ),
          Icon(
            Icons.play_circle_fill,
            size: 49.0,
          ),
        ],
      ),
    );
  }
}
