import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ielts/screens/login_screen.dart';
import 'package:ielts/screens/main_dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  Rx<User?> _user = Rx<User?>(null);
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // New state variables
  var isLoading = false.obs;
  var isOnboardingCompleted = false.obs;

  Rx<User?> get user => _user;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
    _checkOnboardingStatus();
  }

  _initialScreen(User? user) {
    if (user == null) {
      print("Login Page");
    } else {
      print("Home Page");
    }
  }

  Future<void> _checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    isOnboardingCompleted.value =
        prefs.getBool('onboarding_completed') ?? false;
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
    isOnboardingCompleted.value = true;
  }

  void register(String email, password, String name) async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create user document in Firestore
      await firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'totalPoints': 0.0,
        'badges': [],
        'createdAt': FieldValue.serverTimestamp(),
      });

      Get.offAll(() => MainDashboardScreen());

      Get.snackbar("Success", "Account created successfully");
    } catch (e) {
      Get.snackbar(
        "Account Creation Failed",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void login(String email, password) async {
    try {
      isLoading.value = true;
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAll(() => MainDashboardScreen());
      Get.snackbar("Success", "Logged in successfully");
    } catch (e) {
      Get.snackbar(
        "Login Failed",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void signOut() async {
    await auth.signOut();
    Get.offAll(() => LoginScreen());
  }
}
