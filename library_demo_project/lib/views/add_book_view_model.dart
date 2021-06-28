import 'package:flutter/material.dart';
import 'package:library_demo_project/models/book_model.dart';
import 'package:library_demo_project/services/calculator.dart';
import 'package:library_demo_project/services/database.dart';

class AddBookViewModel extends ChangeNotifier {
  Database _database = Database();
  String collectionPath = 'books';

  Future<void> addNewBook(
      {String bookName, String authorName, DateTime publishDate}) async {
    /// Form alanındaki verileri ile önce bir book objesi oluşturulması
    Book newBook = Book(
        id: DateTime.now().toIso8601String(),
        bookName: bookName,
        authorName: authorName,
        publishDate: Calculator.datetimeToTimestamp(publishDate),
        borrows: []);

    /// bu kitap bilgisini database servisi üzerinden Firestore'a yazacak
    await _database.setBookData(
        collectionPath: collectionPath, bookAsMap: newBook.toMap());
  }
}
