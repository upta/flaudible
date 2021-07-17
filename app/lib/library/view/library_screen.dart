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
        appBar: AppBar(
          actions: const [
            SearchButton(),
          ],
        ),
        body: Column(
          children: [
            _buildTabs(tabs),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Text("All"),
                    Text("Podcasts"),
                    Text("Authors"),
                    Text("Genres"),
                    Text("Collections"),
                  ],
                ),
              ),
            ),
          ],
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
