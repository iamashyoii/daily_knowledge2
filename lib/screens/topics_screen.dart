import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> topics = [
      {'name': 'الكل', 'icon': Icons.all_inclusive},
      {'name': 'علم', 'icon': Icons.science},
      {'name': 'تاريخ', 'icon': Icons.history},
      {'name': 'تقنية', 'icon': Icons.computer},
      {'name': 'صحة', 'icon': Icons.health_and_safety},
      {'name': 'ثقافة', 'icon': Icons.public},
      {'name': 'فضاء', 'icon': Icons.rocket_launch},
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('المواضيع'),
          titleTextStyle: TextStyle(color: Colors.white),
          backgroundColor: Color.fromARGB(255, 49, 79, 68),
        ),
        body: ListView.builder(
          itemCount: topics.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(
                topics[index]['icon'],
                color: Color.fromARGB(255, 127, 185, 163),
              ),
              title: Text(topics[index]['name']),
              onTap: () {
                Provider.of<ThemeProvider>(
                  context,
                  listen: false,
                ).setCategory(topics[index]['name']);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('تم اختيار قسم ${topics[index]['name']}'),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
