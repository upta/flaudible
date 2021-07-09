class Book {
  const Book({
    required this.author,
    required this.image,
    required this.title,
    required this.length,
    this.played = const Duration(),
  });

  final String author;
  final String image;
  final String title;
  final Duration length;
  final Duration played;
}
