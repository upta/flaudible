import 'package:app/audible_icons_icons.dart';
import 'package:app/data/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final continueList = ref.watch(continueListeningProvider);

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/audible_logo_bw_ko.png"),
        leadingWidth: 110.0,
        actions: [
          IconButton(
            icon: const Icon(AudibleIcons.search),
            iconSize: 20.0,
            color: Colors.grey.shade400,
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 20.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good afternoon, Brian.',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 8.0),
              Text(
                'You have 3 credits to spend.',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Colors.grey.shade400),
              ),
              SizedBox(height: 8.0),
              ListTile(
                contentPadding: EdgeInsets.only(left: 0.0),
                title: Text(
                  'Continue Listening',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                trailing: Icon(
                  AudibleIcons.chevron_right,
                  size: 17.0,
                ),
              ),
              SizedBox(height: 10.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 9.0,
                  children: continueList.map((a) {
                    return Container(
                      width: 145.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              FadeInImage.assetNetwork(
                                height: 145.0,
                                placeholder: 'assets/loading.png',
                                image: a.image,
                              ),
                              Icon(
                                Icons.circle,
                                color: Colors.black,
                                size: 30.0,
                              ),
                              Icon(
                                AudibleIcons.play,
                                size: 48.0,
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              a.title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4.0,
                              horizontal: 8.0,
                            ),
                            child: TimePlayed(
                              length: a.length,
                              played: a.played,
                            ),
                          )
                        ],
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TimePlayed extends StatelessWidget {
  const TimePlayed({Key? key, required this.length, required this.played})
      : super(key: key);

  final Duration length;
  final Duration played;

  @override
  Widget build(BuildContext context) {
    final diff = length - played;

    final label = diff.inHours > 0
        ? '${diff.inHours}h ${diff.inMinutes % 60}m'
        : '${diff.inMinutes % 60}m';

    return Row(
      children: [
        Flexible(
          child: LinearProgressIndicator(
            backgroundColor: Colors.grey.shade800,
            value: played.inMinutes.toDouble() / length.inMinutes.toDouble(),
            valueColor: AlwaysStoppedAnimation(
              Colors.orange,
            ),
          ),
          flex: 62,
        ),
        Spacer(
          flex: 6,
        ),
        Flexible(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
          flex: 32,
        )
      ],
    );
  }
}
