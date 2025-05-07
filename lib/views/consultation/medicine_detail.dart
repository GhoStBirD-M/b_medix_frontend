import 'package:flutter/material.dart';
import '../../views/widgets/medicine/action_button.dart';
import '../../views/widgets/medicine/detail_section.dart';
import '../../views/widgets/medicine/expandable_section.dart';
import '../../views/widgets/medicine/price_section.dart';
import '../../views/widgets/medicine/rating_section.dart';
import '../widgets/medicine/medicine_detail_appbar.dart';
import '../widgets/medicine/medicine_image_carousel.dart';

class MedicineDetail extends StatelessWidget {
  const MedicineDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar Component
            const MedicineDetailAppbar(title: 'Detail Product'),
            
            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image Carousel Component
                    const MedicineImageCarousel(
                      imagePath: 'assets/images/multivitamin.png',
                      currentIndex: 0,
                      totalImages: 3,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Product Details Container
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Title
                          const Text(
                            'Kids Multivitamin Gummies',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Price Section Component
                          const PriceSection(
                            price: 34.70,
                            unit: 'KG',
                            discount: 22.04,
                            regularPrice: 56.70,
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Rating Section Component
                          const RatingSection(
                            rating: 4.5,
                            reviewCount: 110,
                          ),
                          
                          const SizedBox(height: 24),
                          
                          // Details Section Component
                          const DetailsSection(
                            details: 'Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Nullam quis risus eget urna mollis ornare vel eu leo.',
                          ),
                          
                          const SizedBox(height: 24),
                          
                          // Expandable Sections
                          const ExpandableSection(
                            title: 'Nutritional facts',
                          ),
                          
                          const SizedBox(height: 16),
                          
                          const ExpandableSection(
                            title: 'Reviews',
                          ),
                          
                          const SizedBox(height: 24),
                          
                          // Action Buttons Component
                          const ActionButtons(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}