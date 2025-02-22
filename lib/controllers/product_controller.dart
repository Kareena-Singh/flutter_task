import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductController extends GetxController {
  var products = [].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  // Function to fetch products from API
  void fetchProducts() async {
    try {
      isLoading(true);
      var response =
      await http.get(Uri.parse("https://automationexercise.com/api/productsList"));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        // Updating the products list with fetched data
        products.assignAll(data['products']);
      }
    } finally {
      isLoading(false);
    }
  }
}
