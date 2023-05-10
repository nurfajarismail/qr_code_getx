import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_code_getx/app/controllers/auth_controller.dart';
import 'package:qr_code_getx/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  TextEditingController emailC = TextEditingController(text: "admin@gmail.com");
  TextEditingController passC = TextEditingController(text: "admin123");

  final AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('LoginView'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextField(
              autocorrect: true,
              keyboardType: TextInputType.emailAddress,
              controller: emailC,
              decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(
              height: 20,
            ),
            Obx(
              () => TextField(
                autocorrect: true,
                keyboardType: TextInputType.emailAddress,
                controller: passC,
                obscureText: controller.isHidden.value,
                decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.isHidden.toggle();
                      },
                      icon: Icon(controller.isHidden.isFalse
                          ? Icons.remove_red_eye
                          : Icons.remove_red_eye_outlined),
                    )),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
                    controller.isLoading(true);

                    Map<String, dynamic> result =
                        await authController.login(emailC.text, passC.text);
                    controller.isLoading(false);

                    if (result["error"] == true) {
                      Get.snackbar("Error", result["message"]);
                    } else {
                      Get.offAllNamed(Routes.home);
                    }
                  } else {
                    Get.snackbar("Error", "Email dan password wajib diisi");
                  }
                }
              },
              child: Obx(() =>
                  Text(controller.isLoading.isFalse ? "LOGIN" : "LOADING...")),
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
            )
          ],
        ));
  }
}
