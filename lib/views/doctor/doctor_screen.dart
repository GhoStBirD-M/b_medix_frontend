import 'package:tes_main/views/widgets/bottom_navigation.dart';

import '../widgets/doctor/pharmacy_card.dart';
import './doctor_chat_screen.dart';
import '../widgets/doctor/doctor_list_item.dart';
import 'package:flutter/material.dart';


class DoctorScreen extends StatefulWidget {
  const DoctorScreen({Key? key}) : super(key: key);

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Consultation',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const Icon(Icons.notifications_outlined),
                  const SizedBox(width: 16),
                  const Icon(Icons.shopping_basket_outlined),
                ],
              ),
            ),

            // Tab Bar
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 0.5),
                ),
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.teal,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.teal,
                tabs: const [
                  Tab(text: 'Consultation'),
                  Tab(text: 'Medicine'),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Find A Doctor Or Specialist',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ),

            // Content
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  // Contact Pharmacy Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Contact Pharmacy',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'See all',
                          style: TextStyle(
                            color: Colors.teal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  // Pharmacy Cards
                  PharmacyCard(
                    name: 'Anna Pharmacy',
                    address: '123 main st, springfield',
                    rating: '4.8',
                    hours: '01:00 - 08:00 PM',
                    logoPath: 'assets/pharmacy_logo1.png',
                    onMessageTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DoctorChatScreen(),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  PharmacyCard(
                    name: 'Anna Pharmacy',
                    address: '123 main st, springfield',
                    rating: '4.8',
                    hours: '01:00 - 08:00 PM',
                    logoPath: 'assets/pharmacy_logo2.png',
                    onMessageTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DoctorChatScreen(),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Contact Doctor Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Contact Doctor',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'See all',
                          style: TextStyle(
                            color: Colors.teal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  // Doctor List
                  DoctorListItem(
                    name: 'Dr. Bell Patel',
                    specialty: 'Neurologist',
                    imagePath: 'assets/doctor1.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DoctorChatScreen(),
                        ),
                      );
                    },
                  ),
                  
                  DoctorListItem(
                    name: 'Dr. James Patel',
                    specialty: 'Mental Psychologist',
                    imagePath: 'assets/doctor2.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DoctorChatScreen(),
                        ),
                      );
                    },
                  ),
                  
                  DoctorListItem(
                    name: 'Dr. Olivia Carter',
                    specialty: 'Cardiologist',
                    imagePath: 'assets/doctor3.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DoctorChatScreen(),
                        ),
                      );
                    },
                  ),
                  
                  DoctorListItem(
                    name: 'Dr. Sarah Collins',
                    specialty: 'Cardiologist',
                    imagePath: 'assets/doctor4.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DoctorChatScreen(),
                        ),
                      );
                    },
                  ),
                  
                  DoctorListItem(
                    name: 'Dr. Jonathan Lawrance',
                    specialty: 'Cardiologist',
                    imagePath: 'assets/doctor5.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DoctorChatScreen(),
                        ),
                      );
                    },
                  ),
                  
                  DoctorListItem(
                    name: 'Dr. Ibrahimović',
                    specialty: 'Physical fitness',
                    imagePath: 'assets/doctor6.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DoctorChatScreen(),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 80), // Space for bottom navigation
                ],
              ),
            ),
          ],
        )
      ),
      bottomNavigationBar: BottomNavigation(currentIndex: 1),
    );
  }
}
