import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        // اكتشاف التمرير للأعلى
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! < 0) {
            // إذا كانت السرعة سالبة يعني التمرير للأعلى
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
        child: Stack(
          children: [
            // 1. الخلفية (صورة أو لون)
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/welcome.jpg',
                  ), // تأكدي من وجود الصورة
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // طبقة تعتيم للخلفية
            Container(color: Color.fromARGB(255, 49, 79, 68)),

            // 2. المحتوى الرئيسي
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // أيقونة المصباح بجانب النص
                  Column(
                    children: const [
                      Icon(
                        Icons.lightbulb,
                        color: Color.fromARGB(255, 244, 205, 86),
                        size: 70,
                      ),

                      SizedBox(height: 20),

                      Text(
                        'مرحباً بك في\nالمعلومة اليومية',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 100),

                  // 3. السهم الممتد للأعلى وحركة التمرير
                  Column(
                    children: [
                      const Icon(
                        Icons.keyboard_arrow_up,
                        color: Colors.white,
                        size: 50,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'مرر للأعلى للبدء',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 16,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
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
