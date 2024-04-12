import 'package:book_library_app/models/book.dart';
import 'package:book_library_app/utils/book_arguments.dart';
import 'package:flutter/material.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({
    super.key,
    required List<Book> books,
  }) : _books = books;

  final List<Book> _books;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.builder(
            itemCount: _books.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.6),
            itemBuilder: (context, index) {
              Book book = _books[index];
              return GestureDetector(
                onTap: () => {
                  Navigator.pushNamed(context, '/details',
                      arguments:
                          BookArguments(itemBook: book, isBookmarked: false)),
                },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 14.0, right: 14.0, top: 12.0, bottom: 7.0),
                          child: Image.network(
                            book.imageLinks["thumbnail"]!,
                            scale: 0.95,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 14.0, right: 14.0),
                          child: Text(
                            book.title,
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 14.0, right: 14.0),
                          child: Text(
                            book.authors.join(", "),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
