import 'package:book_library_app/models/book.dart';
import 'package:book_library_app/network/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Book> _books = [];
  Network network = Network();
  Future<void> _searchBooks(String query) async {
    try {
      List<Book> books = await network.searchBooks(query);
      print("Books: ${books.toString()}");
      setState(() {
        _books = books;
      });
    } catch (err) {
      print("Didn't get anything");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    hintText: "Search Books...",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)))),
                onChanged: (query) => _searchBooks(query),
              ),
            ),

            Expanded(
                child: GridView.builder(
                    itemCount: _books.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 0.6),
                    itemBuilder: (context, index) {
                      Book book = _books[index];
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
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
                                  maxLines: 2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 14.0, right: 14.0),
                                child: Text(
                                  book.authors.join(", "),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.fade,
                                  maxLines: 2,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }))
            // Expanded(
            //   child: SizedBox(
            //     width: double.infinity,
            //     child: ListView.builder(
            //       itemBuilder: (context, index) {
            //         Book book = _books[index];
            //         return ListTile(
            //           title: Text(book.title),
            //           subtitle: Text(book.authors.join(", ")),
            //         );
            //       },
            //       itemCount: _books.length,
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
