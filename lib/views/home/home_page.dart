import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../../views/profile/prescription_screen.dart';
import '../widgets/article/article_widgets.dart';
import '../widgets/medicine/medicine_widgets.dart';
import '../../controllers/home/home_barrel.dart';
import '../widgets/common/common_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentBannerIndex = 0;
  final PageController _bannerController = PageController();
  final homeController = Get.find<HomeController>();
  final medicineController = Get.find<MedicineController>();
  final articleController = Get.find<ArticleController>();
  final authController = Get.find<AuthController>();

  // Global keys for coach mark targets
  final GlobalKey _notificationKey = GlobalKey();
  final GlobalKey _cartKey = GlobalKey();
  final GlobalKey _bannerKey = GlobalKey();
  final GlobalKey _productsKey = GlobalKey();
  final GlobalKey _articlesKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    Get.find<MedicineController>().fetchTopMedicines();
    Get.find<ArticleController>().fetchTopArticles();

    // Trigger tutorial after UI is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController.showTutorial(
        context,
        notificationKey: _notificationKey,
        cartKey: _cartKey,
        bannerKey: _bannerKey,
        productsKey: _productsKey,
        articlesKey: _articlesKey,
      );
    });
  }

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Obx(() {
          final user = authController.user.value;

          if (user == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Header(
                greeting: 'How was Ur Health?',
                name: user.name,
                profilePic: 'assets/images/profile.jpg',
                notificationKey: _notificationKey, // Pass key to Header
                cartKey: _cartKey, // Pass key to Header
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        LayoutBuilder(builder: (context, constraints) {
                          return SizedBox(
                            key: _bannerKey, // Assign key to banner
                            height: constraints.maxWidth * 0.5,
                            child: PageView(
                              controller: _bannerController,
                              onPageChanged: (index) {
                                setState(() {
                                  _currentBannerIndex = index;
                                });
                              },
                              children: [
                                PromotionBanner(
                                    title: 'DISKON OBAT HARI INI!',
                                    description:
                                        'Beli obat dengan harga spesial dan diskon hingga 30%.',
                                    discount: 'HEMAT HINGGA 30%*',
                                    buttonText: 'BELI SEKARANG',
                                    color: Colors.purple.shade100,
                                    imageAssetPath:
                                        'assets/images/medicine_promo.png',
                                    onPressed: () => Get.toNamed(
                                          AppPages.CONSULTATION,
                                          arguments: 1,
                                        )),
                                PromotionBanner(
                                    title: 'ARTIKEL KESEHATAN',
                                    description:
                                        'Baca tips sehat, info penyakit, dan gaya hidup sehat.',
                                    discount: 'ARTIKEL BARU',
                                    buttonText: 'BACA ARTIKEL',
                                    color: Colors.amber.shade100,
                                    imageAssetPath:
                                        'assets/images/health_articles.png',
                                    onPressed: () => Get.toNamed(
                                          AppPages.ARTICLE,
                                        )),
                                PromotionBanner(
                                    title: 'PUNYA RESEP DOKTER?',
                                    description:
                                        'Unggah resep dari dokter untuk pengingat obat.',
                                    discount: 'MUDAH, CEPAT, DAN AMAN',
                                    buttonText: 'UNGGAH RESEP',
                                    color: Colors.lightGreen.shade100,
                                    imageAssetPath:
                                        'assets/images/upload_prescription.png',
                                    onPressed: () => Get.to(
                                          PrescriptionScreen(),
                                        )),
                                PromotionBanner(
                                    title: 'KONSULTASI DOKTER',
                                    description:
                                        'Butuh saran medis cepat? Tanya langsung dari rumah.',
                                    discount: 'GRATIS TANPA BIAYA',
                                    buttonText: 'CHAT SEKARANG',
                                    color: Colors.lightBlue.shade100,
                                    imageAssetPath:
                                        'assets/images/doctor_consult.png',
                                    onPressed: () => Get.toNamed(
                                          AppPages.CONSULTATION,
                                        )),
                              ],
                            ),
                          );
                        }),

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
                          key: _productsKey, // Assign key to products section
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Popular Product',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () => Get.toNamed(
                                    AppPages.CONSULTATION,
                                    arguments: 1),
                                child: const Text('See all')),
                          ],
                        ),

                        Obx(() {
                          if (medicineController.isLoading.value) {
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(16),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                              itemCount: 3,
                              itemBuilder: (context, index) =>
                                  const MedicineCardShimmer(),
                            );
                          } else if (medicineController.topMedicines.isEmpty) {
                            return const Center(
                                child: Text('No medicines found'));
                          }
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(16),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                            itemCount: medicineController.topMedicines.length,
                            itemBuilder: (context, index) {
                              final medicine =
                                  medicineController.topMedicines[index];
                              return GestureDetector(
                                onTap: () {
                                  medicineController
                                      .fetchMedicineDetails(medicine.id);
                                  Get.toNamed(AppPages.MEDICINE_DETAILS,
                                      arguments: medicine.id);
                                },
                                child: MedicineCard(medicine: medicine),
                              );
                            },
                          );
                        }),

                        const SizedBox(height: 24),

                        // Articles
                        Row(
                          key: _articlesKey, // Assign key to articles section
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Popular Article',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            TextButton(
                                onPressed: () =>
                                    Get.offAllNamed(AppPages.ARTICLE),
                                child: const Text('See all')),
                          ],
                        ),

                        Obx(() {
                          if (articleController.isLoading.value) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 3,
                              itemBuilder: (context, index) =>
                                  const ArticleCardShimmer(),
                            );
                          } else if (articleController.topArticles.isEmpty) {
                            return const Center(
                                child: Text('No articles found'));
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: articleController.topArticles.length,
                            itemBuilder: (context, index) {
                              final article =
                                  articleController.topArticles[index];
                              return ArticleCard(
                                  article: article,
                                  controller: articleController);
                            },
                          );
                        }),

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