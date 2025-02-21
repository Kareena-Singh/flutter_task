import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';
import '../services/notifications.dart';
import 'ProductDetailScreen.dart';

class HomeScreen extends StatelessWidget {
  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product List")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(hintText: "Search..."),
              onChanged: (value) {
                controller.products.assignAll(controller.products
                    .where((product) =>
                    product['name'].toLowerCase().contains(value.toLowerCase()))
                    .toList());
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  var product = controller.products[index];
                  return ListTile(
                    title: Text(product['name']),
                    subtitle: Text("\$${product['price']}"),
                    onTap: () {
                      Get.to(() => ProductDetailScreen(product: product));
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),

      // ADD THIS BUTTON TO TEST NOTIFICATIONS
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Notification button clicked!"); // Debug log
          NotificationService.showNotification(); // Manually trigger a notification
        },
        child: Icon(Icons.notifications),
      ),
    );
  }
}
