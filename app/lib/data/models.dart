class Book {
  const Book({
    required this.author,
    required this.image,
    required this.title,
    this.length = const Duration(),
    this.played = const Duration(),
    this.includedInOriginals = false,
    this.url = "",
    this.currentChapter = "",
    this.numberOfEpisodes = 0,
    this.wasStarted = false,
    this.wasFinished = false,
    this.isDownloaded = false,
  });

  final String author;
  final String image;
  final String title;
  final Duration length;
  final Duration played;
  final bool includedInOriginals;
  final String url;
  final String currentChapter;
  final int numberOfEpisodes;
  final bool wasStarted;
  final bool wasFinished;
  final bool isDownloaded;
}
