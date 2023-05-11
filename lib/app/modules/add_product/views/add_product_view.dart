import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  AddProductView({Key? key}) : super(key: key);

  TextEditingController codeC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController qtyC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('AddProductView'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextField(
              autocorrect: true,
              keyboardType: TextInputType.number,
              controller: codeC,
              maxLength: 10,
              decoration: InputDecoration(
                  labelText: "Product Code",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              autocorrect: true,
              keyboardType: TextInputType.text,
              controller: nameC,
              decoration: InputDecoration(
                  labelText: "Product Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              autocorrect: true,
              keyboardType: TextInputType.number,
              controller: qtyC,
              decoration: InputDecoration(
                  labelText: "Quantity",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  if (codeC.text.isNotEmpty &&
                      nameC.text.isNotEmpty &&
                      qtyC.text.isNotEmpty) {
                    controller.isLoading(true);
                    Map<String, dynamic> result = await controller.addProduct({
                      "code": codeC.text,
                      "name": nameC.text,
                      "qty": int.tryParse(qtyC.text) ?? 0
                    });
                    controller.isLoading(false);
                    Get.back();
                    Get.snackbar(result["error"] == true ? "Error" : "Sukses",
                        result["message"]);
                  } else {
                    Get.snackbar("Error", "Data wajib diisi semua");
                  }
                }
              },
              child: Obx(() =>
                  Text(controller.isLoading.isFalse ? "TAMBAH" : "LOADING...")),
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
            )
          ],
        ));
  }
}
