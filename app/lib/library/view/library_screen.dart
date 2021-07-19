import 'package:flaudible/app/widget/search_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LibraryScreen extends HookConsumerWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const tabs = ["All", "Podcasts", "Authors", "Genres", "Collections"];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        // appBar: AppBar(
        //   actions: const [
        //     SearchButton(),
        //   ],
        // ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: TabHeader(
                  height: 32.0,
                ),
                pinned: true,
                floating: true,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Text("index $index");
                  },
                  childCount: 1000,
                ),
              )
              // _buildTabs(tabs),
              // const Expanded(
              //   child: Padding(
              //     padding: EdgeInsets.all(16.0),
              //     child: TabBarView(
              //       physics: NeverScrollableScrollPhysics(),
              //       children: [
              //         Text("All"),
              //         Text("Podcasts"),
              //         Text("Authors"),
              //         Text("Genres"),
              //         Text("Collections"),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabs(List<String> tabs) {
    return TabBar(
      labelStyle: const TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        height: 0.0,
      ),
      unselectedLabelColor: Colors.grey,
      unselectedLabelStyle: const TextStyle(
        fontSize: 18.0,
      ),
      tabs: tabs
          .map(
            (e) => SizedBox(
              height: 30.0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(e),
              ),
            ),
          )
          .toList(),
      isScrollable: true,
      indicator: const BoxDecoration(),
    );
  }
}

class TabHeader extends SliverPersistentHeaderDelegate {
  TabHeader({
    required this.height,
  });

  final double height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                Opacity(
                  opacity: (shrinkOffset / 50.0).clamp(0.0, 1.0),
                  child: const Text("All"),
                ),
                const SearchButton(),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.teal,
            ),
            height: (50.0 - shrinkOffset).clamp(0.0, double.infinity),
          ),
          const Text("imma subtab")
        ],
      ),
    );
  }

  @override
  double get maxExtent => 100.0;

  @override
  double get minExtent => 50.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
