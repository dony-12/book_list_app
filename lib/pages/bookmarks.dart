import 'package:book_library_app/db/database_helper.dart';
import 'package:book_library_app/models/book.dart';
import 'package:book_library_app/utils/book_arguments.dart';
import 'package:flutter/material.dart';

class Bookmarks extends StatefulWidget {
  const Bookmarks({super.key});

  @override
  State<Bookmarks> createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  final _books = DatabaseHelper.instance.readAllBooks();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Bookmarks",
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: FutureBuilder<List<Book>>(
            future: DatabaseHelper.instance.readAllBooks(),
            builder: (context, snapshot) => snapshot.hasData
                ? GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 0.6),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Book book = snapshot.data![index];
                      return GestureDetector(
                        onTap: () => {
                          Navigator.pushNamed(context, '/details',
                              arguments: BookArguments(
                                  itemBook: book, isBookmarked: true)),
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceVariant,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 14.0,
                                      right: 14.0,
                                      top: 12.0,
                                      bottom: 7.0),
                                  child: Image.network(
                                    book.imageLinks["thumbnail"]!,
                                    scale: 0.95,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 14.0, right: 14.0),
                                  child: Text(
                                    book.title,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            int savedInt = await DatabaseHelper
                                                .instance
                                                .delete(book.id);
                                            SnackBar snackBar = SnackBar(
                                                content: Text(
                                                    "Book Deleted from bookmarks $savedInt"));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                            setState(() {});
                                          },
                                          child: const Text("Delete",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 241, 6, 6))),
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            await DatabaseHelper.instance
                                                .toggleFavouriteStatus(
                                                    book.id, !book.isFavorite)
                                                .then((value) => print(
                                                    "Added to favourites $value"));
                                            setState(() {});
                                          },
                                          child: !book.isFavorite
                                              ? const Icon(
                                                  Icons.favorite_border)
                                              : const Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                ),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                : const Center(child: CircularProgressIndicator())));
  }
}
