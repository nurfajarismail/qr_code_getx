import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  String? uid;
  late FirebaseAuth auth;

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return {"error": false, "message": "Berhasil login"};
    } on FirebaseAuthException catch (e) {
      return {"error": true, "message": "${e.message}"};
    } catch (e) {
      return {"error": true, "message": "Anda tidak dapat login"};
    }
  }

  Future<Map<String, dynamic>> logout() async {
    try {
      await auth.signOut();
      return {"error": false, "message": "Berhasil logout"};
    } on FirebaseAuthException catch (e) {
      return {"error": true, "message": "${e.message}"};
    } catch (e) {
      return {"error": true, "message": "Anda tidak dapat logout"};
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((event) {
      uid = event?.uid;
    });
    super.onInit();
  }
}