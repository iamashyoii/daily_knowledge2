import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<ThemeProvider>(context).favorites;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('معلوماتي المحفوظة'),
          backgroundColor: Color.fromARGB(255, 49, 79, 68),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: favorites.isEmpty
            ? const Center(child: Text('لم تقم بحفظ أي معلومات بعد'))
            : ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(favorites[index]['text']!),
                      subtitle: Text('المصدر: ${favorites[index]['source']}'),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Color.fromARGB(255, 186, 186, 186),
                        ),
                        onPressed: () => Provider.of<ThemeProvider>(
                          context,
                          listen: false,
                        ).toggleFavorite(favorites[index]),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
