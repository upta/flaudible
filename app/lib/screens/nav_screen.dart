import 'package:app/audible_icons_icons.dart';
import 'package:app/data/providers.dart';
import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:marquee/marquee.dart';

class NavScreen extends StatefulWidget {
  NavScreen({Key? key}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _selectedIndex = 1;

  final _screens = [
    HomeScreen(),
    const Scaffold(body: Center(child: Text("Library"))),
    const Scaffold(body: Center(child: Text("Discover"))),
    const Scaffold(body: Center(child: Text("Profile"))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: _screens
          .asMap()
          .map(
            (i, a) => MapEntry(
              i,
              Offstage(
                child: a,
                offstage: _selectedIndex != i,
              ),
            ),
          )
          .values
          .toList(),
    );
  }

  Widget _buildBottomNav() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MiniPlayer(),
        Container(
          height: 0.5,
          decoration: BoxDecoration(
            color: Colors.black45,
          ),
        ),
        BottomNavigationBar(
          currentIndex: _selectedIndex,
          iconSize: 28.0,
          items: [
            _icon(
              icon: AudibleIcons.home_outline,
              activeIcon: AudibleIcons.home,
              label: 'Home',
            ),
            _icon(
              icon: AudibleIcons.library_books,
              activeIcon: AudibleIcons.library_books,
              label: 'Library',
              inactiveColor: Colors.grey.shade600,
            ),
            _icon(
              icon: AudibleIcons.discover_outline,
              activeIcon: AudibleIcons.discover,
              label: 'Discover',
            ),
            _icon(
              icon: AudibleIcons.profile_outline,
              activeIcon: AudibleIcons.profile,
              label: 'Profile',
            ),
          ],
          onTap: (index) => setState(() => _selectedIndex = index),
          showUnselectedLabels: true,
          selectedFontSize: 12.0,
          type: BottomNavigationBarType.fixed,
          unselectedFontSize: 12.0,
        ),
      ],
    );
  }

  BottomNavigationBarItem _icon({
    required IconData icon,
    required IconData activeIcon,
    required String? label,
    Color? inactiveColor,
  }) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Icon(
          icon,
          size: 22.0,
          color: inactiveColor,
        ),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Icon(
          activeIcon,
          size: 22.0,
        ),
      ),
      label: label,
    );
  }
}

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
