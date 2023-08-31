import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/view/login_view.dart';
import 'package:twitter_clone/features/home/home_view.dart';

import '../../../apis/auth_api.dart';
import '../../../apis/user_api.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authAPI: ref.watch(AuthAPIprovider),
    userAPI: ref.watch(userAPIProvider),
  );
});

final currentUserDetailsProvider = FutureProvider((ref) async {
  final currentUserId = ref.watch(currentUserAccountProvider).value!.$id;
  // print("Current User ID: $currentUserId");
  final userDetails = ref.watch(userDetailsProvider(currentUserId));
  // print(currentUserId);
  return userDetails.value;
});

final userDetailsProvider = FutureProvider.family((ref, String uid) {
  // print("Getting user details for uid: $uid");
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

class AuthController extends StateNotifier<bool> {
  final UserAPI _userAPI;
  final AuthAPI _authAPI;
  AuthController({required AuthAPI authAPI, required UserAPI userAPI})
      : _authAPI = authAPI,
        _userAPI = userAPI,
        super(false);

  // state = isLoading

  Future<User?> currentUser() => _authAPI.currentUserAccount();
  void signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.signUp(
      email: email,
      password: password,
    );
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) async {
      UserModel userModel = UserModel(
          email: email,
          name: getNameFromEmail(email),
          profilePic: '',
          bannerPic: '',
          uid: r.$id,
          bio: '',
          istwitterblue: false,
          followers: [],
          following: []);
      final res2 = await _userAPI.saveUserData(userModel);
      res2.fold((l) => showSnackBar(context, l.message), (r) {
        showSnackBar(context, 'Account created! Please login');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginView()));
      });
    });
  }

  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.login(
      email: email,
      password: password,
    );
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) async {
      UserModel userModel = UserModel(
          email: email,
          name: getNameFromEmail(email),
          profilePic: '',
          bannerPic: '',
          uid: r.$id,
          bio: '',
          istwitterblue: false,
          followers: [],
          following: []);
      final res2 = await _userAPI.saveUserData(userModel);
      res2.fold((l) => showSnackBar(context, l.message), (r) {
        showSnackBar(context, 'Successful Login!');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomeView()));
      });
    });
  }

  Future<UserModel> getUserData(String uid) async {
    final document = await _userAPI.getUserData(uid);
    // print(' user is ::: $uid');
    final updatedUser = UserModel.fromMap(document.data);
    return updatedUser;
  }

  void logout(BuildContext context) async {
    final res = await _authAPI.logout();
    res.fold((l) => null, (r) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginView()),
          (route) => false);
    });
  }
}
