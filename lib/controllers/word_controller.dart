import 'package:crud_firebase_flutter/models/word_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WordController extends GetxController {
  var isLoading = false.obs;
  var wordList = <WordModel>[].obs;
  final formKey = GlobalKey<FormState>();
  var title = ''.obs;
  var meaning = ''.obs;
  var titleEditing = TextEditingController();
  var meaningEditing = TextEditingController();

  Future<void> getData() async {
    try {
      isLoading(true);
      QuerySnapshot words = await FirebaseFirestore.instance
          .collection('word_bank')
          .orderBy('title')
          .get();
      wordList.clear();
      for (var word in words.docs) {
        wordList.add(WordModel(word['title'], word['meaning'], word.id));
      }
      isLoading(false);
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void addWord() {
    FirebaseFirestore.instance
        .collection('word_bank')
        .add({'title': title.value, 'meaning': meaning.value});
    meaningEditing.clear();
    titleEditing.clear();
    update();
  }

  void updateWord(String documentId) {
    FirebaseFirestore.instance.collection('word_bank').doc(documentId).update({
      'title': title.value,
      'meaning': meaning.value,
    });
    meaningEditing.clear();
    titleEditing.clear();
    update();
  }

  void deleteWord(String id) async {
    await FirebaseFirestore.instance.collection('word_bank').doc(id).delete();
    update();
  }
}
