import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  // تأكدي أن المسار يبدأ بـ assets/images/ مرة واحدة فقط
  String _currentBackground = 'assets/images/nature.jpg';
  final List<Map<String, String>> _favorites = [];
  String _selectedCategory = 'الكل';

  String get currentBackground => _currentBackground;
  List<Map<String, String>> get favorites => _favorites;
  String get selectedCategory => _selectedCategory;

  void setBackground(String imagePath) {
    _currentBackground = imagePath; // تحديث الخلفية
    notifyListeners(); // إشعار التطبيق بالتغيير
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void toggleFavorite(Map<String, String> fact) {
    if (_favorites.any((element) => element['text'] == fact['text'])) {
      _favorites.removeWhere((element) => element['text'] == fact['text']);
    } else {
      _favorites.add(fact);
    }
    notifyListeners();
  }

  bool isFavorite(Map<String, String> fact) {
    return _favorites.any((element) => element['text'] == fact['text']);
  }

  void clearAllFavorites() {
    _favorites.clear();
    notifyListeners();
  }
}
