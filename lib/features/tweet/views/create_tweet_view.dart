import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_clone/common/rounded_small_button.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/tweet/controller/tweet_controller.dart';
import 'package:twitter_clone/theme/pallete.dart';

import '../../../main.dart';

class CreateTweetScreen extends ConsumerStatefulWidget {
  const CreateTweetScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateTweetScreenState();
}

class _CreateTweetScreenState extends ConsumerState<CreateTweetScreen> {
  final tweetTextController = TextEditingController();
  List<File> images = [];
  @override
  void dispose() {
    super.dispose();
    tweetTextController.dispose();
  }

  void shareTweet() {
    ref.read(tweetControllerProvider.notifier).shareTweet(
        images: images, text: tweetTextController.text, context: context);
    print("tweet button clicked");
  }

  void onPickImages() async {
    images = await pickImages();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;
    final isLoading = ref.watch(tweetControllerProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Apptheme.theme,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                size: 30,
              )),
          actions: [
            RoundedSmallButton(
                onTap: shareTweet,
                label: "Tweet",
                backgroundColor: Pallete.blueColor,
                textColor: Pallete.whiteColor)
          ],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    // backgroundImage: NetworkImage(currentUser.profilePic),
                    backgroundImage: AssetImage("assets/svgs/images.jpeg"),

                    radius: 30,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: TextField(
                      controller: tweetTextController,
                      style: const TextStyle(fontSize: 22),
                      decoration: const InputDecoration(
                          hintText: "What's happening?",
                          hintStyle: TextStyle(
                              color: Pallete.greyColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w600),
                          border: InputBorder.none),
                      maxLines: null,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              if (images.isNotEmpty)
                CarouselSlider(
                    items: images.map((file) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                file,
                                fit: BoxFit.cover,
                              )));
                    }).toList(),
                    options: CarouselOptions(
                        height: 400, enableInfiniteScroll: false))
            ],
          ),
        )),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(bottom: 18),
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(color: Pallete.greyColor, width: 0.4))),
          child: Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.all(8.0).copyWith(left: 15, right: 15),
                child: GestureDetector(
                    onTap: onPickImages,
                    child: SvgPicture.asset(AssetsConstants.galleryIcon)),
              ),
              Padding(
                padding:
                    const EdgeInsets.all(8.0).copyWith(left: 15, right: 15),
                child: SvgPicture.asset(AssetsConstants.gifIcon),
              ),
              Padding(
                padding:
                    const EdgeInsets.all(8.0).copyWith(left: 15, right: 15),
                child: SvgPicture.asset(AssetsConstants.emojiIcon),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  final ImagePicker picker = ImagePicker();
  final imageFiles = await picker.pickMultiImage();
  if (imageFiles.isNotEmpty) {
    for (final image in imageFiles) {
      images.add(File(image.path));
    }
  }
  return images;
}
