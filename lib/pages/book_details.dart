import 'package:book_library_app/db/database_helper.dart';
import 'package:book_library_app/models/book.dart';
import 'package:book_library_app/utils/book_arguments.dart';
import 'package:flutter/material.dart';

class BookDetails extends StatefulWidget {
  const BookDetails({super.key});

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as BookArguments;
    final Book book = args.itemBook;
    final bool isBookmarked = args.isBookmarked;
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: SingleChildScrollView(
        // controller: controller,
        child: Column(children: [
          if (book.imageLinks.isNotEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 14.0, right: 14.0, top: 12.0, bottom: 7.0),
                child: Image.network(
                  book.imageLinks["thumbnail"]!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          Column(
            children: [
              Text(
                book.title,
                style: theme.titleLarge,
                textAlign: TextAlign.center,
              ),
              Text("Authors: ${book.authors.join(", ")}",
                  style: theme.bodySmall),
              Text(
                "Published: ${book.publisher}",
                style: theme.bodySmall,
              ),
              Text(
                "Page Count: ${book.pageCount}",
                style: theme.bodySmall,
              ),
              Text(
                "Language: ${book.language}",
                style: theme.bodySmall,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              !isBookmarked
                  ? Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ElevatedButton.icon(
                          onPressed: () async {
                            try {
                              int savedInt =
                                  await DatabaseHelper.instance.insert(book);
                              SnackBar snackBar = SnackBar(
                                  content: Text("Book Saved $savedInt"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } catch (e) {
                              print("Error: $e");
                            }
                            setState(() {});
                          },
                          icon: const Icon(Icons.add),
                          label: const Text("Bookmark")),
                    )
                  : const SizedBox(),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Description",
            style: theme.bodyLarge,
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(style: BorderStyle.solid)),
                padding: const EdgeInsets.all(12.0),
                child: Text(book.description)),
          )
        ]),
      ),
    );
  }
}
