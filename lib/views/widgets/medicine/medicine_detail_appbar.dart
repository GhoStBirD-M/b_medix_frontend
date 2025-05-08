import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tes_main/routes/app_pages.dart';

class MedicineDetailAppbar extends StatelessWidget {
  final String title;
  const MedicineDetailAppbar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.lightBlue.shade100,
              borderRadius: BorderRadius.circular(25),
            ),
            child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                      ),
                      onPressed: () => Get.offAllNamed(AppPages.DOCTOR),
                    ),
            
          ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 50), // For balance
        ],
      ),
    );
  }
}
