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
            icon: const Icon(Icons.search),
            iconSize: 28.0,
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 24.0,
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
                  Icons.chevron_right,
                  size: 30.0,
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
                                Icons.play_circle_fill,
                                size: 56.0,
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
