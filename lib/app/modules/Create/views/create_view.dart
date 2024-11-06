import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/create_controller.dart';

class CreateView extends StatelessWidget {
  final CreateController controller = Get.put(CreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Momen'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 16.0),
              Text("Describe your feeling now"),
              SizedBox(
                height: 16,
              ),
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
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: controller.titleController,
                decoration: InputDecoration(
                  labelText: 'Judul',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: controller.momentController,
                decoration: InputDecoration(
                  labelText: 'Momen',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Memanggil metode addData dari controller
                  controller.addData(
                    controller.titleController.text,
                    controller.momentController.text,
                  );
                },
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
