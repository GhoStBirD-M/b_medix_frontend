import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../../views/profile/prescription_screen.dart';
import '../../views/widgets/article/article_card.dart';
import '../../views/widgets/article/article_card_shimmer.dart';
import '../../views/widgets/medicine/medicine_cards_shimmer.dart';
import '../../views/widgets/medicine/medicine_cards.dart';
import '../../controllers/article_controller.dart';
import '../../controllers/medicine_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/home_controller.dart';
import '../widgets/common/bottom_navigation.dart';
import '../widgets/common/header.dart';
import '../widgets/common/promotion_banner.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentBannerIndex = 0;
  final PageController _bannerController = PageController();
  final HomeController homeController = Get.find<HomeController>();
  final MedicineController medicineController = Get.put(MedicineController());
  final ArticleController articleController = Get.put(ArticleController());
  final AuthController authController = Get.find<AuthController>();

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Get.find<MedicineController>().fetchTopMedicines();
    Get.find<ArticleController>().fetchTopArticles();
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
                                    color: const Color(0xFFD7D0FF),
                                    imageAssetPath:
                                        'images/medicine_promo.png',
                                    onPressed: () => Get.toNamed(
                                          AppPages.CONSULTATION,
                                          arguments: 1,
                                        )),
                                PromotionBanner(
                                    title: 'BACA ARTIKEL KESEHATAN',
                                    description:
                                        'Baca tips sehat, info penyakit, dan gaya hidup sehat.',
                                    discount: 'ARTIKEL DIPERBARUI TIAP MINGGU',
                                    buttonText: 'BACA ARTIKEL',
                                    color: const Color(0xFFFFF3E0),
                                    imageAssetPath:
                                        'images/health_articles.png',
                                    onPressed: () => Get.toNamed(
                                          AppPages.ARTICLE,
                                        )),
                                PromotionBanner(
                                    title: 'PUNYA RESEP DOKTER?',
                                    description:
                                        'Unggah resep dari dokter untuk pengingat obat.',
                                    discount: 'MUDAH, CEPAT, DAN AMAN',
                                    buttonText: 'UNGGAH RESEP',
                                    color: const Color(0xFFE8F5E9),
                                    imageAssetPath:
                                        'images/upload_prescription.png',
                                    onPressed: () => Get.to(
                                          PrescriptionScreen(),
                                        )),
                                PromotionBanner(
                                    title: 'KONSULTASI DOKTER ONLINE',
                                    description:
                                        'Butuh saran medis cepat? Konsultasi langsung dari rumah.',
                                    discount: 'GRATIS UNTUK PENGGUNA BARU',
                                    buttonText: 'KONSULTASI SEKARANG',
                                    color: const Color(0xFFF3E5F5),
                                    imageAssetPath:
                                        'images/doctor_consult.png',
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Popular Product',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () =>
                                    Get.toNamed(AppPages.CONSULTATION, arguments: 1),
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
                              itemCount: 3, // jumlah shimmer cards saat loading
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
