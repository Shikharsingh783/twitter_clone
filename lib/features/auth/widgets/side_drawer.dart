import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone/constants/assets_constants.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/theme/theme.dart';

class SideDrawer extends ConsumerWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final currentUser = ref.watch(currentUserDetailsProvider).value;

    // if (currentUser == null) {
    //   return const Loader();
    // }

    return SafeArea(
      child: Drawer(
        backgroundColor: Pallete.backgroundColor,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            ListTile(
              leading: const Icon(
                Icons.person_outline_outlined,
                size: 30,
              ),
              title: const Text(
                "Profile",
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: SvgPicture.asset(
                AssetsConstants.verifiedIcon,
                height: 30,
              ),
              title: Text(
                "Blue",
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                size: 30,
              ),
              title: const Text(
                "Log Out",
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                ref.read(authControllerProvider.notifier).logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
