import 'package:book_library_app/components/grid_view.dart';
import 'package:book_library_app/models/book.dart';
import 'package:book_library_app/network/network.dart';
import 'package:flutter/material.dart';

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
            GridViewWidget(books: _books)
          ],
        ),
      ),
    );
  }
}
