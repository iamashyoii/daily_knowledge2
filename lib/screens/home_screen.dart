import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../theme_provider.dart';
import '../data/facts_data.dart';
import 'themes_screen.dart';
import 'settings_screen.dart';
import 'topics_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const MainFactView(),
    const TopicsScreen(),
    const ThemesScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromARGB(255, 49, 79, 68),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'المواضيع',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.palette), label: 'الثيمات'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'الإعدادات',
          ),
        ],
      ),
    );
  }
}

class MainFactView extends StatefulWidget {
  const MainFactView({super.key});

  @override
  State<MainFactView> createState() => _MainFactViewState();
}

class _MainFactViewState extends State<MainFactView> {
  late List shuffledFacts;

  @override
  void initState() {
    super.initState();

    shuffledFacts = List.from(allFacts);

    shuffledFacts.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    final filteredFacts = provider.selectedCategory == 'الكل'
        ? shuffledFacts
        : shuffledFacts
              .where((f) => f.category == provider.selectedCategory)
              .toList();

    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: filteredFacts.length,
      itemBuilder: (context, index) {
        final fact = filteredFacts[index];
        return Stack(
          children: [
            // خلفية الثيم مع المسار المصحح
            Positioned.fill(
              key: ValueKey(provider.currentBackground),
              child: Image.asset(
                provider.currentBackground,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(color: Colors.blueGrey),
              ),
            ),
            Container(color: Colors.black.withOpacity(0.6)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    fact.text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 60),
                  // الصف المحدث بـ 3 أزرار
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _ActionButton(
                        icon:
                            provider.isFavorite({
                              'text': fact.text,
                              'source': fact.source,
                            })
                            ? Icons.favorite
                            : Icons.favorite_border,
                        label: 'مفضلة',
                        color:
                            provider.isFavorite({
                              'text': fact.text,
                              'source': fact.source,
                            })
                            ? Colors.red
                            : Colors.white,
                        onTap: () => provider.toggleFavorite({
                          'text': fact.text,
                          'source': fact.source,
                        }),
                      ),

                      // زر المصدر الجديد
                      _ActionButton(
                        icon: Icons.info_outline,
                        label: 'المصدر',
                        color: const Color.fromARGB(255, 255, 255, 254),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('مصدر المعلومة'),
                              content: Text(fact.source),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('إغلاق'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      _ActionButton(
                        icon: Icons.share,
                        label: 'مشاركة',
                        color: Colors.white,
                        onTap: () => Share.share(
                          '💡 ${fact.text}\nالمصدر: ${fact.source}',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: color, size: 30),
          onPressed: onTap,
        ),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}
