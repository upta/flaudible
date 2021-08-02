import 'package:diffutil_sliverlist/diffutil_sliverlist.dart';
import 'package:flaudible/data/data.dart';
import 'package:flaudible/library/library.dart';
import 'package:flaudible/library/provider/all_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AllTab extends HookConsumerWidget {
  const AllTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final books = ref.watch(allBooksProvider);

    return DiffUtilSliverList(
      items: books,
      builder: (context, Book item) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: BookRow(
            book: item,
          ),
        );
      },
      insertAnimationBuilder: (context, animation, child) {
        return FadeTransition(
          opacity: animation,
          child: SizeTransition(
            sizeFactor: animation,
            child: child,
          ),
        );
      },
      removeAnimationBuilder: (context, animation, child) {
        return FadeTransition(
          opacity: animation,
          child: SizeTransition(
            sizeFactor: animation,
            child: child,
          ),
        );
      },
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
        SizedBox(
          width: 93.0,
          height: 93.0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              FadeInImage.assetNetwork(
                placeholder: 'assets/loading.png',
                image: book.image,
              ),
              if (!book.isDownloaded) const DownloadOverlay(),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.0),
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
        ),
        _buildMoreIcon(
          context,
          book,
        ),
      ],
    );
  }

  Widget _buildMoreIcon(
    BuildContext context,
    Book book,
  ) {
    if (book.numberOfEpisodes > 0) {
      return const Padding(
        padding: EdgeInsets.only(right: 5.0),
        child: Icon(
          AudibleIcons.chevron_right,
          size: 19.0,
        ),
      );
    }

    return GestureDetector(
      child: const Icon(
        Icons.more_vert,
        size: 28.0,
      ),
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: const MoreSheet(),
            );
          },
        );
      },
    );
  }
}

class MoreSheet extends StatelessWidget {
  const MoreSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 16.0,
            ),
            child: Column(
              children: [
                _buildItem(Icons.share_outlined, 'Share'),
                _buildItem(Icons.details_outlined, 'Details'),
                _buildItem(
                  AudibleIcons.download_arrow,
                  'Download',
                  iconSize: 16.0,
                ),
                _buildItem(Icons.favorite_outline, 'Add to favorites'),
                _buildItem(Icons.archive_outlined, 'Archive this title'),
                _buildItem(Icons.add_to_queue, 'Add to ...'),
                _buildItem(Icons.check_circle_outline, 'Mark as finished'),
                _buildItem(Icons.rate_review_outlined, 'Rate & review'),
              ],
            ),
          ),
        ),
        Container(
          height: 0.5,
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.white24),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              "Close",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildItem(IconData icon, String label, {double iconSize = 24.0}) {
    return Expanded(
      child: Row(
        children: [
          SizedBox(
            width: 24.0,
            child: Icon(
              icon,
              color: Colors.white70,
              size: iconSize,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 17.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
