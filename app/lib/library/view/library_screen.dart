import 'package:flaudible/app/widget/search_button.dart';
import 'package:flaudible/library/widget/all_sub_tab.dart';
import 'package:flaudible/library/widget/all_tab.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainTabController = useTabController(initialLength: tabs.length);
    final mainTabindex = useState(0);

    mainTabController.addListener(() {
      mainTabindex.value = mainTabController.index;
    });

    final tabHeader = TabHeader(
      tabs: tabs,
      tabController: mainTabController,
    );

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: const Color.fromARGB(255, 34, 34, 39),
          color: Colors.orange,
          strokeWidth: 2.75,
          edgeOffset: tabHeader.fullHeight,
          onRefresh: () async {
            return Future.delayed(const Duration(seconds: 2));
          },
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: tabHeader,
                pinned: true,
                floating: true,
              ),
              SliverOffstage(
                offstage: mainTabindex.value != 0,
                sliver: const AllTab(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TabHeader extends SliverPersistentHeaderDelegate {
  TabHeader({
    required this.tabs,
    required this.tabController,
  }) {
    _subTabsHeight = _calcSubTabHeight();
  }

  final List<String> tabs;
  final TabController tabController;

  double get fullHeight => _searchHeight + _tabsHeight + _subTabsHeight;

  final double _searchHeight = kToolbarHeight;
  final double _tabsHeight = 40.0;
  double _subTabsHeight = 0.0;

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
      child: MainTabBar(
        length: tabs.length,
        tabBuilder: (_, index, isActive) {
          final style = isActive
              ? const TextStyle(
                  fontSize: 34.0,
                  fontWeight: FontWeight.bold,
                )
              : const TextStyle(
                  color: Colors.grey,
                  fontSize: 20.0,
                );

          return Text(
            tabs[index],
            style: style,
          );
        },
        tabController: tabController,
      ),
    );
  }

  Widget _buildSubTabs() {
    final tabs = [
      AllSubTab(),
    ];

    return Stack(
      children: tabs
          .asMap()
          .map(
            (i, a) => MapEntry(
              i,
              Offstage(
                child: a,
                offstage: tabController.index != i,
              ),
            ),
          )
          .values
          .toList(),
    );
  }

  double _calcSubTabHeight() {
    if (tabController.index == 0) {
      return AllSubTab.height;
    }

    return 0;
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

class MainTabBar extends HookWidget {
  MainTabBar({
    Key? key,
    required this.length,
    required this.tabBuilder,
    required this.tabController,
  }) : super(key: key);

  final int length;
  final Widget Function(
    BuildContext context,
    int index,
    bool isActive,
  ) tabBuilder;
  final TabController tabController;
  late final _iterable = Iterable<int>.generate(length);

  @override
  Widget build(BuildContext context) {
    final keys = useState(
      _iterable.map((index) => GlobalKey()).toList(),
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: _iterable.map(
          (index) {
            final key = keys.value[index];

            return GestureDetector(
              key: key,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: tabBuilder(
                  context,
                  index,
                  tabController.index == index,
                ),
              ),
              onTap: () async {
                tabController.animateTo(index);

                await Future.delayed(
                  const Duration(milliseconds: 50),
                ); // ensuring the text style has changed before animating

                Scrollable.ensureVisible(
                  key.currentContext!,
                  duration: const Duration(
                    milliseconds: 200,
                  ),
                  alignment: 0.5,
                );
              },
            );
          },
        ).toList(),
      ),
    );
  }
}
