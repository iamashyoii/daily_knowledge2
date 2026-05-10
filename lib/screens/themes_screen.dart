import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';

class ThemesScreen extends StatelessWidget {
  const ThemesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // قائمة الـ 10 صور كما هي موجودة في مجلدك الفعلي
    final List<Map<String, dynamic>> themes = [
      {'name': 'حيوانات', 'path': 'assets/images/animals.jpg'},
      {'name': 'صحراء', 'path': 'assets/images/desert.jpg'},
      {'name': 'غابة', 'path': 'assets/images/forest.jpg'},
      {'name': 'تاريخ', 'path': 'assets/images/history.jpg'},
      {'name': 'جبال', 'path': 'assets/images/mountains.jpg'},
      {'name': 'طبيعة', 'path': 'assets/images/nature.jpg'},
      {'name': 'بحر', 'path': 'assets/images/sea.jpg'},
      {'name': 'فضاء', 'path': 'assets/images/space.jpg'},
      {'name': 'نجوم', 'path': 'assets/images/stars.jpg'},
      {'name': 'تقنية', 'path': 'assets/images/tech.jpg'},
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('اختيار الثيم'),
          backgroundColor: Color.fromARGB(255, 49, 79, 68),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.85,
          ),
          itemCount: themes.length,
          itemBuilder: (context, index) {
            final isSelected =
                context.watch<ThemeProvider>().currentBackground ==
                themes[index]['path'];

            return InkWell(
              onTap: () {
                // هذا السطر هو الذي يغير الخلفية في الهوم سكرين
                context.read<ThemeProvider>().setBackground(
                  themes[index]['path']!,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('تم تفعيل ثيم ${themes[index]['name']}'),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: isSelected
                        ? Color.fromARGB(255, 127, 185, 163)
                        : Colors.grey.shade300,
                    width: 3,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        themes[index]['path']!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.image),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        color: Colors.black45,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          themes[index]['name']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
