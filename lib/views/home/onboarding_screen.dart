import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/home/onboarding_controller.dart';
import '../widgets/common/onboarding_item.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: controller.skipOnboarding,
                    child: Text(
                      'Skip',
                      style: GoogleFonts.poppins(
                        color: Colors.teal.shade600,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemCount: controller.onboardingItems.length,
                itemBuilder: (context, index) {
                  return OnboardingItemWidget(
                    item: controller.onboardingItems[index],
                  );
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
              child: Column(
                children: [
                  // Dots indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      controller.onboardingItems.length,
                      (index) => Obx(() {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          width: controller.currentPage.value == index ? 12 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: controller.currentPage.value == index
                                ? Colors.teal.shade600
                                : Colors.teal.shade200,
                            shape: BoxShape.circle,
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Next button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: Obx(() {
                      final isLastPage = controller.currentPage.value ==
                          controller.onboardingItems.length - 1;
                      return OutlinedButton(
                        onPressed: controller.nextPage,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.teal.shade600,
                          side: BorderSide(
                              color: Colors.teal.shade600, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor:
                              isLastPage ? Colors.teal.shade600 : Colors.white,
                        ),
                        child: Text(
                          isLastPage ? 'Get Started' : 'Next',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: isLastPage
                                ? Colors.white
                                : Colors.teal.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
