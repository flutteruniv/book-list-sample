import 'package:book_list_sample/domain/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookListModel extends ChangeNotifier {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('books').snapshots();

  List<Book>? books;

  void fetchBookList() {
    _usersStream.listen((QuerySnapshot snapshot) {
      final List<Book> books = snapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        final String title = data['title'];
        final String author = data['author'];
        return Book(title, author);
      }).toList();

      this.books = books;
      notifyListeners();
    });
  }
}
