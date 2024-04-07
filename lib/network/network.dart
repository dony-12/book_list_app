import 'dart:convert';
import 'package:book_library_app/models/book.dart';
import 'package:http/http.dart' as http;

class Network {
  //API Endpoint

  static const String _baseEndpoint =
      "https://www.googleapis.com/books/v1/volumes";

  Future<List<Book>> searchBooks(String query) async {
    var url = Uri.parse("$_baseEndpoint?q=$query");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data["items"] != null && data["items"] is List) {
        List<Book> books = (data["items"] as List<dynamic>)
            .map((book) => Book.fromJson(book as Map<String, dynamic>))
            .toList();
        return books;
      } else {
        return [];
      }
    } else {
      throw Exception("Failed to load books");
    }
  }
}
