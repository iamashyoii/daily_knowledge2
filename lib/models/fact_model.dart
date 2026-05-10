class FactModel {
  final int id;
  final String text; // تم تغييرها من fact لتطابق الكود في HomeScreen
  final String source;
  final String category; // تم تغييرها من topic لتطابق الكود في HomeScreen

  FactModel({
    required this.id,
    required this.text,
    required this.source,
    required this.category,
  });
}
