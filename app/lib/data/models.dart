class Book {
  const Book({
    required this.author,
    required this.image,
    required this.title,
    this.length = const Duration(),
    this.played = const Duration(),
  });

  final String author;
  final String image;
  final String title;
  final Duration length;
  final Duration played;
}
