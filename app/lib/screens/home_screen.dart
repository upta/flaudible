import 'package:app/audible_icons_icons.dart';
import 'package:app/data/models.dart';
import 'package:app/data/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final continueList = ref.watch(continueListeningProvider);
    final becauseYouListened = ref.watch(becauseYouListenedProvider);
    final audibleOriginals = ref.watch(audibleOriginalsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/audible_logo_bw_ko.png"),
        leadingWidth: 110.0,
        actions: [
          IconButton(
            icon: const Icon(AudibleIcons.search),
            iconSize: 20.0,
            color: Colors.grey.shade400,
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 0.5,
            decoration: BoxDecoration(
              color: Colors.black12,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 16.0,
                ),
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
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      trailing: Icon(
                        AudibleIcons.chevron_right,
                        size: 17.0,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    BookList(
                      books: continueList,
                      itemSize: 145.0,
                      itemSpacing: 9.0,
                      titleInset: 8.0,
                      onTap: (Book book) {},
                      footerBuilder: (_, book) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                          ),
                          child: TimePlayed(
                            length: book.length,
                            played: book.played,
                          ),
                        );
                      },
                      overlayBuilder: (_, book) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.circle,
                              color: Colors.black,
                              size: 30.0,
                            ),
                            Icon(
                              AudibleIcons.play,
                              size: 48.0,
                            )
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 18.0),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 0.0),
                      title: Text(
                        'Because you listened to Rhythm of War',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    BookList(
                      books: becauseYouListened,
                      itemSize: 123.0,
                      itemSpacing: 13.0,
                      onTap: (Book book) {},
                      footerBuilder: (_, book) {
                        return Text(
                          'by ${book.author}',
                          style: Theme.of(context).textTheme.caption,
                        );
                      },
                    ),
                    SizedBox(height: 8.0),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 0.0),
                      title: Text(
                        "Our newest can't-miss Audible Originals",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    BookList(
                      books: audibleOriginals,
                      itemSize: 123.0,
                      itemSpacing: 13.0,
                      onTap: (Book book) {},
                      footerBuilder: (_, book) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'by ${book.author}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                            if (book.includedInOriginals)
                              SizedBox(
                                height: 9.0,
                              ),
                            if (book.includedInOriginals)
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(2.0),
                                  ),
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Colors.orange.shade400,
                                      Colors.orange.shade600,
                                    ],
                                  ),
                                ),
                                padding: EdgeInsets.only(
                                  top: 3.0,
                                  left: 3.0,
                                  right: 3.0,
                                  bottom: 2.0,
                                ),
                                child: Text(
                                  "INCLUDED",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 11.0,
                                      ),
                                ),
                              )
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Browse all Originals >",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BookList extends StatelessWidget {
  const BookList({
    Key? key,
    required this.books,
    required this.itemSize,
    required this.itemSpacing,
    required this.onTap,
    this.titleInset = 0.0,
    this.footerBuilder,
    this.overlayBuilder,
  }) : super(key: key);

  final List<Book> books;
  final double itemSize;
  final double itemSpacing;
  final double titleInset;
  final void Function(Book book) onTap;
  final Widget Function(BuildContext context, Book book)? footerBuilder;
  final Widget Function(BuildContext context, Book book)? overlayBuilder;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        direction: Axis.horizontal,
        spacing: itemSpacing,
        children: books.map((book) {
          Widget? footer;
          Widget? overlay;

          if (this.footerBuilder != null) {
            footer = this.footerBuilder!(context, book);
          }

          if (this.overlayBuilder != null) {
            overlay = this.overlayBuilder!(context, book);
          }

          return GestureDetector(
            onTap: () => onTap(book),
            child: BookDisplay(
              book: book,
              size: itemSize,
              titleInset: titleInset,
              footer: footer,
              overlay: overlay,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class BookDisplay extends StatelessWidget {
  BookDisplay({
    Key? key,
    required this.book,
    required this.size,
    required this.titleInset,
    this.footer,
    this.overlay,
  }) : super(key: key);

  final Book book;
  final double size;
  final double titleInset;
  final Widget? footer;
  final Widget? overlay;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              FadeInImage.assetNetwork(
                height: size,
                placeholder: 'assets/loading.png',
                image: book.image,
              ),
              if (this.overlay != null) this.overlay!
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              left: titleInset,
              right: titleInset,
              top: 8.0,
              bottom: 13.0,
            ),
            child: Text(
              book.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (this.footer != null) this.footer!
        ],
      ),
    );
  }
}

class TimePlayed extends StatelessWidget {
  const TimePlayed({Key? key, required this.length, required this.played})
      : super(key: key);

  final Duration length;
  final Duration played;

  @override
  Widget build(BuildContext context) {
    final diff = length - played;

    final label = diff.inHours > 0
        ? '${diff.inHours}h ${diff.inMinutes % 60}m'
        : '${diff.inMinutes % 60}m';

    return Row(
      children: [
        Flexible(
          child: LinearProgressIndicator(
            backgroundColor: Colors.grey.shade800,
            value: played.inMinutes.toDouble() / length.inMinutes.toDouble(),
            valueColor: AlwaysStoppedAnimation(
              Colors.orange,
            ),
          ),
          flex: 62,
        ),
        Spacer(
          flex: 6,
        ),
        Flexible(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
          flex: 32,
        )
      ],
    );
  }
}
