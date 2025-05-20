import 'package:flutter/material.dart';

class ConsultationTabBar extends StatelessWidget {
  final TabController tabController;

  const ConsultationTabBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      child: TabBar(
        controller: tabController,
        labelColor: Colors.teal,
        unselectedLabelColor: Colors.grey,
        indicatorColor: Colors.teal,
        tabs: const [
          Tab(text: 'Consultation'),
          Tab(text: 'Medicine'),
        ],
      ),
    );
  }
}
