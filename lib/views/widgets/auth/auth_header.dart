import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200,
        height: 200,
        child: Stack(
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                color: Color(0xFF0CB8A9),
                shape: BoxShape.circle,
              ),
            ),
            Positioned(
              top: 30,
              left: 40,
              child: Transform.rotate(
                angle: -0.3,
                child: Container(
                  width: 100,
                  height: 160,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4DEFE3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF0A9E91),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Color(0xFF0A9E91),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(height: 60),
                      Container(
                        width: 60,
                        height: 24,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0CB8A9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 20,
              bottom: 40,
              child: Container(
                width: 140,
                height: 30,
                decoration: BoxDecoration(
                  color: const Color(0xFF4DEFE3),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: const Color(0xFF0A9E91),
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) => const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      child: Text(
                        '*',
                        style: TextStyle(
                          color: Color(0xFF0A9E91),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 20,
              bottom: 20,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF4DEFE3),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFF0A9E91),
                    width: 2,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.lock,
                    color: Color(0xFF0A9E91),
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
