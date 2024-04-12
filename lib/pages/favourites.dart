import 'package:book_library_app/db/database_helper.dart';
import 'package:book_library_app/models/book.dart';
import 'package:flutter/material.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Favourites",
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: FutureBuilder(
            future: DatabaseHelper.instance.getFavourites(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Error: ${snapshot.error}",
                  ),
                );
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                List<Book> favBooks = snapshot.data!;

                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ListView.builder(
                      itemCount: favBooks.length,
                      itemBuilder: (context, index) {
                        Book book = favBooks[index];
                        return Card(
                            child: ListTile(
                          leading: Image.network(
                            book.imageLinks['thumbnail'] ?? '',
                            fit: BoxFit.cover,
                          ),
                          title: Text(book.title),
                          trailing: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                        ));
                      }),
                );
              } else {
                return const Center(child: Text("No Favourites"));
              }
            }));
  }
}
