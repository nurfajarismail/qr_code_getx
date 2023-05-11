import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_code_getx/app/controllers/auth_controller.dart';
import 'package:qr_code_getx/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(20),
        itemCount: 4,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
        itemBuilder: (context, index) {
          late String title;
          late IconData iconData;
          late VoidCallback onTab;

          switch (index) {
            case 0:
              title = "Add Product";
              iconData = Icons.post_add_rounded;
              onTab = () {
                Get.toNamed(Routes.addProduct);
              };
              break;
            case 1:
              title = "Product";
              iconData = Icons.list_alt_rounded;
              onTab = () {
                Get.toNamed(Routes.products);
              };
              break;
            case 2:
              title = "Qr Code";
              iconData = Icons.qr_code_2_rounded;
              onTab = () {
                Get.toNamed(Routes.addProduct);
              };
              break;
            case 3:
              title = "Catalog";
              iconData = Icons.document_scanner_rounded;
              onTab = () {
                Get.toNamed(Routes.addProduct);
              };
              break;
            default:
          }
          return Material(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              onTap: onTab,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Icon(
                      iconData,
                      size: 50,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(title)
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Map<String, dynamic> result = await authController.logout();

          if (result["error"] == true) {
            Get.snackbar("Error", result["message"]);
          } else {
            Get.offAllNamed(Routes.login);
          }
        },
        child: Icon(Icons.logout),
      ),
    );
  }
}
