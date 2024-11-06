import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  Color getBackgroundColor(String emoticon) {
    switch (emoticon) {
      case 'happy':
        return Colors.yellow.shade100;
      case 'sad':
        return Colors.blue.shade100;
      case 'angry':
        return Colors.red.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: const Text('Halo, Name'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: IconButton(
              onPressed: () {
                controller.logout();
              },
              icon: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: controller.getMoments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Belum ada momen yang ditambahkan"));
          }

          // Menampilkan data momen dari Firestore
          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final data = snapshot.data![index];
              String title = data['title'] ?? 'No Title';
              String name = data['createdBy'] ?? 'No Name';
              String moment = data['moment'] ?? 'No Moment';
              String emoticon = data['emoticon'] ?? 'neutral';
              String momentId = data['id'];

              return Dismissible(
                key: Key(momentId),
                direction: DismissDirection.endToStart,
                background: Container(
                  decoration: BoxDecoration(
                    color: Colors.red.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  controller.deleteMoment(momentId);
                  Get.snackbar("Sukses", "Momen berhasil dihapus.");
                },
                child: GestureDetector(
                  onLongPress: () {
                    Get.toNamed(Routes.EDIT, arguments: momentId);
                  },
                  child: Card(
                    color: getBackgroundColor(emoticon),
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title),
                          SizedBox(height: 4),
                          Text(
                            moment,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      leading: Text(
                        emoticon == 'happy'
                            ? '😊'
                            : emoticon == 'sad'
                                ? '😢'
                                : emoticon == 'angry'
                                    ? '😡'
                                    : '😐',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppPages.Create);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
