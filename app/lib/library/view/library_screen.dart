import 'package:flaudible/app/widget/search_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LibraryScreen extends HookConsumerWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  final tabs = const [
    "All",
    "Podcasts",
    "Authors",
    "Genres",
    "Collections",
  ];

  final subTabs = const [
    "All Titles",
    "Not Started",
    "Started",
    "Downloaded",
    "Finished",
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainTabController = useTabController(initialLength: tabs.length);
    final subTabController = useTabController(initialLength: subTabs.length);
    final mainTabindex = useState(0);
    final subTabindex = useState(0);
    // final key = GlobalKey();

    mainTabController.addListener(() {
      mainTabindex.value = mainTabController.index;
    });

    subTabController.addListener(() {
      subTabindex.value = subTabController.index;
    });

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: TabHeader(
                tabs: tabs,
                tabController: mainTabController,
                subTabs: subTabs,
                subTabController: subTabController,
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
            ),
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
    );
  }
}

class TabHeader extends SliverPersistentHeaderDelegate {
  const TabHeader({
    required this.tabs,
    required this.tabController,
    required this.subTabs,
    required this.subTabController,
  });

  final List<String> tabs;
  final TabController tabController;
  final List<String> subTabs;
  final TabController subTabController;

  final double _searchHeight = kToolbarHeight;
  final double _tabsHeight = 30.0;
  final double _subTabsHeight = 15.0 + 34.0 + 35.0 + 36.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSearch(
            context,
            shrinkOffset,
          ),
          _buildTabs(
            shrinkOffset,
          ),
          _buildSubTabs(),
        ],
      ),
    );
  }

  Widget _buildSearch(
    BuildContext context,
    double shrinkOffset,
  ) {
    final textOpacity = (shrinkOffset / _searchHeight).clamp(0.0, 1.0);

    return SizedBox(
      height: _searchHeight,
      child: NavigationToolbar(
        centerMiddle: true,
        middle: Opacity(
          opacity: textOpacity,
          child: const Text(
            "All",
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        trailing: const SearchButton(),
      ),
    );
  }

  Widget _buildTabs(
    double shrinkOffset,
  ) {
    return SizedBox(
      height: (_tabsHeight - shrinkOffset).clamp(0.0, double.infinity),
      child: Padding(
        padding: const EdgeInsets.only(left: 0.0),
        child: TabBar(
          controller: tabController,
          labelStyle: const TextStyle(
            fontSize: 34.0,
            fontWeight: FontWeight.bold,
            height: 0.0,
          ),
          labelPadding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 0.0,
          ),
          unselectedLabelColor: Colors.grey,
          unselectedLabelStyle: const TextStyle(
            fontSize: 20.0,
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
        ),
      ),
    );
  }

  Widget _buildSubTabs() {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15.0,
          ),
          TabBar(
            unselectedLabelColor: Colors.grey,
            controller: subTabController,
            labelPadding: const EdgeInsets.only(right: 8.0),
            tabs: subTabs
                .map(
                  (tab) => Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(4.0),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 6.0,
                      horizontal: 16.0,
                    ),
                    child: Text(
                      tab,
                      style: const TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                )
                .toList(),
            isScrollable: true,
            indicator: const BoxDecoration(),
          ),
          const SizedBox(
            height: 25.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "115 titles",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    "Release Date",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 35.0,
                  ),
                  SizedBox(
                    width: 14.0,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => _searchHeight + _tabsHeight + _subTabsHeight;

  @override
  double get minExtent => _searchHeight + _subTabsHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
