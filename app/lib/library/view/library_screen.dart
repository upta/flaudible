import 'package:flaudible/app/widget/search_button.dart';
import 'package:flaudible/data/data.dart';
import 'package:flaudible/library/provider/all_provider.dart';
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
    final allBooks = ref.watch(allBooksProvider);
    final mainTabController = useTabController(initialLength: tabs.length);
    final subTabController = useTabController(initialLength: subTabs.length);
    final mainTabindex = useState(0);
    final subTabindex = useState(0);

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
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BookRow(
                      book: allBooks[index],
                    ),
                  );
                },
                childCount: allBooks.length,
              ),
            ),
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
  final double _tabsHeight = 40.0;
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
              Text(
                "${allBooks.length} titles",
                style: const TextStyle(
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

class BookRow extends StatelessWidget {
  const BookRow({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    final duration = book.length.inHours > 0
        ? '${book.length.inHours}h ${book.length.inMinutes % 60}m'
        : '${book.length.inMinutes % 60}m';

    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            FadeInImage.assetNetwork(
              height: 100.0,
              placeholder: 'assets/loading.png',
              image: book.image,
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  book.numberOfEpisodes == 0
                      ? 'By ${book.author}'
                      : '${book.numberOfEpisodes} episodes',
                  style: Theme.of(context).textTheme.caption,
                ),
                if (book.numberOfEpisodes == 0) ...[
                  const SizedBox(
                    height: 9.0,
                  ),
                  Text(
                    duration,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ]
              ],
            ),
          ),
        )
      ],
    );
  }
}
