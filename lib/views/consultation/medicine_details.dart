import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tes_main/controllers/cart_controller.dart';
import '../../controllers/medicine_controller.dart';

class MedicineDetailScreen extends StatelessWidget {
  final MedicineController controller = Get.find<MedicineController>();
  final CartController cartController = Get.find<CartController>();

  MedicineDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Detail Product',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        final medicine = controller.selectedMedicine.value;

        if (medicine == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    Container(
                      height: 300,
                      width: double.infinity,
                      color: Colors.white,
                      child: Image.network(
                        medicine.imageUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: const Icon(Icons.image_not_supported,
                                size: 100),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        medicine.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            'Rp ${medicine.price}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        medicine.description,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                          height: 1.5,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        child: ExpansionTile(
                          tilePadding: EdgeInsets.zero,
                          title: const Text(
                            'Nutritional facts',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: const Icon(Icons.keyboard_arrow_down),
                          children: [
                            ListTile(
                              title: Text('Calories'),
                              trailing: Text('15 kcal'),
                            ),
                            ListTile(
                              title: Text('Sugar'),
                              trailing: Text('3 g'),
                            ),
                            ListTile(
                              title: Text('Sodium'),
                              trailing: Text('20 mg'),
                            ),
                            ListTile(
                              title: Text('Vitamin C'),
                              trailing: Text('100 mg'),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 200),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Row(
            children: [
              Expanded(
                child: Obx(() {
                  return OutlinedButton(
                    onPressed: cartController.isUpdating.value
                        ? null
                        : () {
                            final medicine = controller.selectedMedicine.value;
                            if (medicine != null) {
                              cartController.addToCart(medicine.id, 1);
                            }
                          },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      side: const BorderSide(color: Colors.teal),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: cartController.isUpdating.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator())
                        : const Text(
                            'Add To Cart',
                            style: TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  );
                }),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    backgroundColor: Color(0xFF0BAB7C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Buy Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
