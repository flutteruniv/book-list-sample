import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfileModel extends ChangeNotifier {
  EditProfileModel(this.name, this.description) {
    nameController.text = name!;
    descriptionController.text = description!;
  }

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  String? name;
  String? description;

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  void setDescription(String description) {
    this.description = description;
    notifyListeners();
  }

  bool isUpdated() {
    return name != null || description != null;
  }

  Future update() async {
    this.name = nameController.text;
    this.description = descriptionController.text;

    // firestoreに追加
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'name': name,
      'description': description,
    });
  }
}
