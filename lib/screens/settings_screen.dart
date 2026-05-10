import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import 'favorites_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _customIconEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الإعدادات'),
          backgroundColor: Color.fromARGB(255, 49, 79, 68),
          foregroundColor: Colors.white,
          elevation: 0,
        ),

        body: ListView(
          children: [
            // --- قسم التنبيهات ---
            const _SectionTitle(title: 'التنبيهات'),
            SwitchListTile(
              secondary: const Icon(
                Icons.notifications_active,
                color: Colors.blueGrey,
              ),
              title: const Text('الإشعارات اليومية'),
              value: _notificationsEnabled,
              onChanged: (val) => setState(() => _notificationsEnabled = val),
            ),

            const Divider(),

            // --- قسم المظهر ---
            const _SectionTitle(title: 'المظهر'),
            SwitchListTile(
              secondary: const Icon(Icons.app_shortcut, color: Colors.blueGrey),
              title: const Text('تغيير شكل أيقونة التطبيق'),
              value: _customIconEnabled,
              onChanged: (val) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('سيتم تفعيل هذه الميزة في المستقبل'),
                    backgroundColor: Colors.blueGrey,
                  ),
                );
              },
            ),

            const Divider(),

            // --- قسم إدارة البيانات ---
            const _SectionTitle(title: 'إدارة البيانات'),
            ListTile(
              leading: const Icon(
                Icons.delete_forever,
                color: Color.fromARGB(255, 186, 186, 186),
              ),
              title: const Text('مسح كافة المفضلات'),
              onTap: () => _confirmClear(context),
            ),
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.red),
              title: const Text('إدارة المفضلة'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavoritesScreen(),
                  ),
                );
              },
            ),
            const Divider(),

            // --- قسم حول التطبيق (الذي تمت إعادته الآن) ---
            const _SectionTitle(title: 'عن التطبيق'),
            AboutListTile(
              icon: const Icon(Icons.info_outline, color: Colors.blueGrey),
              applicationName: 'تطبيق معلومة',
              applicationVersion: '1.0.0',
              applicationLegalese: '© 2026 جميع الحقوق محفوظة',
              child: const Text('حول التطبيق'), // النص الذي يظهر في القائمة
              aboutBoxChildren: [
                const SizedBox(height: 10),
                const Text(
                  'تطبيق "معلومة" هو رفيقك اليومي لاكتشاف حقائق مذهلة وموثقة في مختلف المجالات مثل العلوم، التاريخ، والتقنية.',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // نافذة تأكيد الحذف
  void _confirmClear(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد'),
        content: const Text('هل أنتِ متأكدة من مسح كل المفضلات؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<ThemeProvider>(
                context,
                listen: false,
              ).clearAllFavorites();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم مسح قائمة المفضلات بنجاح')),
              );
            },
            child: const Text('مسح الكل', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

// ويدجت تنسيق عناوين الأقسام
class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          color: Color.fromARGB(255, 127, 185, 163),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
