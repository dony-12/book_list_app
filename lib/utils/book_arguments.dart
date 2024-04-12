import 'package:book_library_app/models/book.dart';

class BookArguments {
  final Book itemBook;
  final bool isBookmarked;

  BookArguments({required this.isBookmarked, required this.itemBook});
}
