import 'package:flaudible/data/data.dart';
import 'package:flaudible/library/provider/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum AllFilter {
  allTitles,
  notStarted,
  started,
  downloaded,
  finished,
}

final filterProvider = StateProvider((ref) => AllFilter.allTitles);

final allBooksProvider = Provider<List<Book>>((ref) {
  final filter = ref.watch(filterProvider);
  final books = ref.watch(booksProvider);

  switch (filter.state) {
    case AllFilter.allTitles:
      return books.toList();
    case AllFilter.notStarted:
      return books.where((a) => !a.wasStarted).toList();
    case AllFilter.started:
      return books.where((a) => a.wasStarted).toList();
    case AllFilter.downloaded:
      return books.where((a) => a.isDownloaded).toList();
    case AllFilter.finished:
      return books.where((a) => a.wasFinished).toList();
  }
});
