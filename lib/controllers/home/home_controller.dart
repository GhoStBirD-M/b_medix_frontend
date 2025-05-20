import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:flutter/material.dart';
import '../../models/auth/user_model.dart';

class HomeController extends GetxController {
  final box = GetStorage();
  final RxBool isTutorialShown = false.obs;
  final Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    getUserData();
    bool hasShownTutorial = box.read('hasShownHomeTutorial') ?? false;
    isTutorialShown.value = hasShownTutorial;
  }

  void getUserData() {
    final userJson = box.read('user');
    if (userJson != null) {
      user.value = User.fromJson(jsonDecode(userJson));
    }
  }

  void showTutorial(
    BuildContext context, {
    required GlobalKey notificationKey,
    required GlobalKey cartKey,
    required GlobalKey bannerKey,
    required GlobalKey productsKey,
    required GlobalKey articlesKey,
  }) {
    if (isTutorialShown.value) return; // Skip if tutorial was already shown

    TutorialCoachMark tutorial = TutorialCoachMark(
      targets: _createTargets(
        notificationKey,
        cartKey,
        bannerKey,
        productsKey,
        articlesKey,
      ),
      colorShadow: Colors.black54,
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: () {
        // Mark tutorial as shown
        box.write('hasShownHomeTutorial', true);
        isTutorialShown.value = true;
      },
      onSkip: () {
        // Mark tutorial as shown if skipped
        box.write('hasShownHomeTutorial', true);
        isTutorialShown.value = true;
        return true;
      },
    );

    // Delay to ensure UI is fully rendered
    Future.delayed(const Duration(milliseconds: 500), () {
      tutorial.show(context: context);
    });
  }

  // Define tutorial targets
  // Define tutorial targets
  List<TargetFocus> _createTargets(
    GlobalKey notificationKey,
    GlobalKey cartKey,
    GlobalKey bannerKey,
    GlobalKey productsKey,
    GlobalKey articlesKey,
  ) {
    return [
      TargetFocus(
        identify: "NotificationIcon",
        keyTarget: notificationKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Notification Icon",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Tap here to see notifications about activities like adding items to your cart.",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          ),
        ],
      ),
      TargetFocus(
        identify: "CartIcon",
        keyTarget: cartKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Cart Icon",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "View all products you've added to your cart here.",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          ),
        ],
      ),
      TargetFocus(
        identify: "BannerNews",
        keyTarget: bannerKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom, // Text below the banner
            padding: const EdgeInsets.only(top: 20.0), // Add spacing
            builder: (context, controller) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "News Banner",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Check out promotions, articles, and more through these banners.",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          ),
        ],
        paddingFocus: 5, // Smaller padding for tighter highlight
        shape: ShapeLightFocus.RRect, // Rounded rectangle highlight
        radius: 10, // Rounded corners
      ),
      TargetFocus(
        identify: "PopularProducts",
        keyTarget: productsKey,
        contents: [
          TargetContent(
            align: ContentAlign.top, // Text above products
            builder: (context, controller) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Popular Products",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Explore frequently purchased medicines here.",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          ),
        ],
        shape: ShapeLightFocus.RRect, // Rounded rectangle highlight
        radius: 10, // Rounded corners
        paddingFocus: 5, // Match banner's tighter highlight
      ),
      TargetFocus(
        identify: "PopularArticles",
        keyTarget: articlesKey,
        contents: [
          TargetContent(
            align: ContentAlign.top, // Text above articles
            builder: (context, controller) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Popular Articles",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Read trending health articles and tips.",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          ),
        ],
        shape: ShapeLightFocus.RRect, // Rounded rectangle highlight
        radius: 10, // Rounded corners
        paddingFocus: 5, // Match banner's tighter highlight
      ),
    ];
  }
}
