import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/home_controller.dart';
import '../widgets/article_card.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/header.dart';
import '../widgets/product_card.dart';
import '../widgets/promotion_banner.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentBannerIndex = 0;
  final PageController _bannerController = PageController();
  final HomeController homeController = Get.find<HomeController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Obx(() {
          final user = authController.user.value;

          if (user == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Header(
                greeting: 'Good Morning!',
                name: user.name,
                avatarUrl: '/placeholder.svg',
              ),

              // Main content
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),

                        // Banner
                        SizedBox(
                          height: 180,
                          child: PageView(
                            controller: _bannerController,
                            onPageChanged: (index) {
                              setState(() {
                                _currentBannerIndex = index;
                              });
                            },
                            children: const [
                              PromotionBanner(
                                title: 'UPLOAD PRESCRIPTION',
                                description:
                                    'Upload a Prescription and Tell Us what you Need. We do the Rest!',
                                discount: 'FLAT 25% OFF ON MEDICINES*',
                                buttonText: 'ORDER NOW',
                                color: Color(0xFFE6E1FF),
                                iconData: Icons.medication,
                              ),
                              PromotionBanner(
                                title: 'UPTO 80% OFFER*',
                                description: 'On Health Products',
                                discount:
                                    'Homeopathy, Ayurvedic, Personal Care & More',
                                buttonText: 'SHOP NOW',
                                color: Color(0xFFD1E8E6),
                                showImage: true,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            4,
                            (index) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentBannerIndex == index
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Products
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Popular Product',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () {}, child: const Text('See all')),
                          ],
                        ),
                        SizedBox(
                          height: 180,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: const [
                              ProductCard(
                                  name: 'Panadol',
                                  quantity: '20pcs',
                                  price: 15.99,
                                  imageUrl: '/placeholder.svg'),
                              ProductCard(
                                  name: 'Bodrex Herbal',
                                  quantity: '100ml',
                                  price: 7.99,
                                  imageUrl: '/placeholder.svg'),
                              ProductCard(
                                  name: 'Konidin',
                                  quantity: '3pcs',
                                  price: 5.99,
                                  imageUrl: '/placeholder.svg'),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Articles
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Popular Article',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            TextButton(
                                onPressed: () {}, child: const Text('See all')),
                          ],
                        ),
                        const ArticleCard(
                          title: 'Understanding the Dangers of Illegal Drugs',
                          author: 'Dr. Ibrahimović',
                          imageUrl: '/placeholder.svg',
                        ),
                        const SizedBox(height: 12),
                        const ArticleCard(
                          title: 'Boost Your Immunity Naturally',
                          author: 'Dr. Jhon Summit',
                          imageUrl: '/placeholder.svg',
                        ),
                        const SizedBox(height: 12),
                        const ArticleCard(
                          title: 'Understanding Sleep Hygiene',
                          author: 'Dr. Jandal Jadi',
                          imageUrl: '/placeholder.svg',
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 0),
    );
  }
}
