import 'package:flaudible/library/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AllSubTab extends HookConsumerWidget {
  AllSubTab({Key? key}) : super(key: key);

  final _subTabs = Map<AllFilter, String>.fromEntries([
    const MapEntry(AllFilter.allTitles, "All Titles"),
    const MapEntry(AllFilter.notStarted, "Not Started"),
    const MapEntry(AllFilter.started, "Started"),
    const MapEntry(AllFilter.downloaded, "Downloaded"),
    const MapEntry(AllFilter.finished, "Finished"),
  ]);

  static const height = 15.0 + 34.0 + 35.0 + 36.0; // do this better

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final books = ref.watch(allBooksProvider);
    final filter = ref.read(filterProvider);
    final controller = useTabController(initialLength: _subTabs.length);

    controller.addListener(() {
      filter.state = _subTabs.entries.elementAt(controller.index).key;
    });

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
            controller: controller,
            labelPadding: const EdgeInsets.only(right: 8.0),
            tabs: _subTabs.entries
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
                      tab.value,
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
                "${books.length} titles",
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
}
