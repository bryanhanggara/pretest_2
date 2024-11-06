import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/edit/controllers/edit_controller.dart';

class EditView extends GetView<EditController> {
  final String momentId;

  EditView({required this.momentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Momen'),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot<Object?>>(
        future: controller.getData(momentId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Data tidak ditemukan'));
          }

          var data = snapshot.data!;
          controller.titleController.text = data['title'] ?? '';
          controller.momentController.text = data['moment'] ?? '';
          String emoticon = data['emoticon'] ?? 'neutral';

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(() => GestureDetector(
                          onTap: () => controller.setEmoticon('happy'),
                          child: CircleAvatar(
                            backgroundColor:
                                controller.selectedEmoticon.value == 'happy'
                                    ? Colors.yellow.shade200
                                    : Colors.grey.shade200,
                            radius: 30,
                            child: Text('😊', style: TextStyle(fontSize: 30)),
                          ),
                        )),
                    SizedBox(width: 10),
                    Obx(() => GestureDetector(
                          onTap: () => controller.setEmoticon('sad'),
                          child: CircleAvatar(
                            backgroundColor:
                                controller.selectedEmoticon.value == 'sad'
                                    ? Colors.blue.shade200
                                    : Colors.grey.shade200,
                            radius: 30,
                            child: Text('😢', style: TextStyle(fontSize: 30)),
                          ),
                        )),
                    SizedBox(width: 10),
                    Obx(() => GestureDetector(
                          onTap: () => controller.setEmoticon('angry'),
                          child: CircleAvatar(
                            backgroundColor:
                                controller.selectedEmoticon.value == 'angry'
                                    ? Colors.red.shade200
                                    : Colors.grey.shade200,
                            radius: 30,
                            child: Text('😡', style: TextStyle(fontSize: 30)),
                          ),
                        )),
                  ],
                ),
                SizedBox(height: 20),
                TextField(
                  controller: controller.titleController,
                  decoration: InputDecoration(
                    labelText: 'Judul',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: controller.momentController,
                  decoration: InputDecoration(
                    labelText: 'Momen',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    controller.updateData(
                      momentId,
                      controller.titleController.text.trim(),
                      controller.momentController.text.trim(),
                      emoticon,
                    );
                  },
                  child: Text('Simpan'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
