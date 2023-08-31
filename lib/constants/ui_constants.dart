import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone/theme/pallete.dart';

import 'assets_constants.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
        color: Pallete.blueColor,
        height: 30,
      ),
      centerTitle: true,
    );
  }

  static List<Widget> bottomTabBarPages = [
    const Text('Feed screen'),
    const Text('Search screen'),
    const Text('Notification screen')
  ];
}
