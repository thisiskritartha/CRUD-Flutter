import 'package:crud_firebase_flutter/controllers/word_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  var controller = Get.put(WordController());

  @override
  Widget build(BuildContext context) {
    controller.getData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        centerTitle: true,
        title: const Text(
          'Word Bank',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontStyle: FontStyle.italic,
            letterSpacing: 2,
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 20.0,
        ),
        child: FloatingActionButton(
          onPressed: () {
            //Creating the data
            Get.defaultDialog(
                title: 'Add the Word',
                confirm: ElevatedButton(
                  onPressed: () {
                    controller.addWord();
                    controller.getData();
                    Get.back();
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.yellow)),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.titleEditing,
                        onChanged: (value) {
                          controller.title.value = value;
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please Enter the Meaning Field.';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        controller: controller.meaningEditing,
                        onChanged: (value) {
                          controller.meaning.value = value;
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please Enter the Meaning Field.';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Meaning',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ));
          },
          backgroundColor: Colors.yellow,
          child: const Icon(
            FontAwesomeIcons.add,
            color: Colors.black,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
                itemCount: controller.wordList.length,
                itemBuilder: (BuildContext ctx, i) {
                  return Dismissible(
                    key: ObjectKey(ctx),
                    onDismissed: (_) {
                      controller.deleteWord(controller.wordList[i].id);
                      controller.getData();
                    },
                    background: Container(
                      color: Colors.red.withOpacity(0.7),
                      alignment: Alignment.centerRight,
                      child: const Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    direction: DismissDirection.endToStart,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Text('${i + 1}.'),
                          title: Text(
                            controller.wordList[i].title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          subtitle: Text(
                            controller.wordList[i].meaning,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              Get.defaultDialog(
                                  title: 'Edit the Word',
                                  confirm: ElevatedButton(
                                    onPressed: () {
                                      // controller.addWord();
                                      controller.updateWord(
                                          controller.wordList[i].id);
                                      controller.getData();
                                      Get.back();
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.yellow)),
                                    child: const Text(
                                      'Confirm',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  content: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: controller.titleEditing,
                                          onChanged: (value) {
                                            controller.title.value = value;
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return 'Please Enter the Meaning Field.';
                                            }
                                            return null;
                                          },
                                          decoration: const InputDecoration(
                                            labelText: 'Title',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        const SizedBox(height: 10.0),
                                        TextFormField(
                                          controller: controller.meaningEditing,
                                          onChanged: (value) {
                                            controller.meaning.value = value;
                                          },
                                          decoration: const InputDecoration(
                                            labelText: 'Meaning',
                                            border: OutlineInputBorder(),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return 'Please Enter the Meaning Field.';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ));
                            },
                            icon: const Icon(FontAwesomeIcons.edit),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, index) {
                  return const Divider(
                    thickness: 2,
                  );
                },
              ),
      ),
    );
  }
}
