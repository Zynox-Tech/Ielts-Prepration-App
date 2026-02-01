import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ielts/controllers/auth_controller.dart';
import 'package:ielts/controllers/theme_controller.dart';
import 'package:ielts/screens/listening_tests_screen.dart';
import 'package:ielts/screens/profile_screen.dart';
import 'package:ielts/screens/reading_tests_screen.dart';
import 'package:ielts/screens/writing_model_screen.dart';
import 'package:ielts/screens/writing_tests_screen.dart';
import 'speaking_screen.dart';
import 'stats_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    final modules = [
      {'title': 'Speaking', 'icon': Icons.mic, 'screen': SpeakingScreen()},
      {'title': 'Writing', 'icon': Icons.edit, 'screen': WritingTestsScreen()},
      {
        'title': 'Model Assessment',
        'icon': Icons.model_training,
        'screen': ScoringScreen(),
      },
      {
        'title': 'Listening',
        'icon': Icons.headphones,
        'screen': ListeningTestsScreen(),
      },
      {
        'title': 'Reading',
        'icon': Icons.menu_book,
        'screen': ReadingTestsScreen(),
      },
      {
        'title': 'Scores Dashboard',
        'icon': Icons.dashboard,
        'screen': const StatsScreen(),
      },
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'IELTS Practice',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).appBarTheme.foregroundColor,
          ),
        ),
      ),
      drawer: _buildDrawer(context, isDark, textColor),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Back,",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "IELTS Master",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                itemCount: modules.length,
                separatorBuilder: (ctx, i) => const SizedBox(height: 16),
                itemBuilder: (ctx, i) {
                  final module = modules[i];
                  return Hero(
                    tag: "module_${module['title']}",
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => module['screen'] as Widget,
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(24),
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: isDark
                                ? []
                                : [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 20,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                            border: Border.all(
                              color: isDark
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade100,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: (module['icon'] == Icons.mic)
                                      ? (isDark
                                            ? const Color(0xFF312E81)
                                            : const Color(0xFFEEF2FF))
                                      : (module['icon'] == Icons.edit)
                                      ? (isDark
                                            ? const Color(0xFF064E3B)
                                            : const Color(0xFFECFDF5))
                                      : (module['icon'] == Icons.headphones)
                                      ? (isDark
                                            ? const Color(0xFF1E3A8A)
                                            : const Color(0xFFDEEDFF))
                                      : (module['icon'] == Icons.menu_book)
                                      ? (isDark
                                            ? const Color(0xFF7C2D12)
                                            : const Color(0xFFFFF7ED))
                                      : (isDark
                                            ? const Color(0xFF78350F)
                                            : const Color(0xFFFEF3C7)),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(24),
                                    bottomLeft: Radius.circular(24),
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    module['icon'] as IconData,
                                    size: 40,
                                    color: (module['icon'] == Icons.mic)
                                        ? const Color(0xFF4F46E5) // Indigo
                                        : (module['icon'] == Icons.edit)
                                        ? const Color(0xFF10B981) // Emerald
                                        : (module['icon'] == Icons.headphones)
                                        ? const Color(0xFF3B82F6) // Blue
                                        : (module['icon'] == Icons.menu_book)
                                        ? const Color(0xFFF97316) // Orange
                                        : const Color(0xFFF59E0B), // Amber
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        module['title'] as String,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: textColor,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Start practicing',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: textColor.withOpacity(0.6),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 18,
                                  color: Colors.grey[300],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, bool isDark, Color textColor) {
    final user = FirebaseAuth.instance.currentUser;
    final themeController = Get.find<ThemeController>();
    final authController = Get.find<AuthController>();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // User Header
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [Color(0xFF1E3A8A), Color(0xFF3B82F6)]
                    : [Color(0xFF3B82F6), Color(0xFF60A5FA)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                user?.email?.substring(0, 1).toUpperCase() ?? 'U',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3B82F6),
                ),
              ),
            ),
            accountName: Text(
              user?.displayName ?? 'IELTS Learner',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
              user?.email ?? 'guest@ielts.com',
              style: TextStyle(fontSize: 14),
            ),
          ),

          // Home
          ListTile(
            leading: Icon(Icons.home, color: textColor),
            title: Text('Home', style: TextStyle(color: textColor)),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          // Profile
          ListTile(
            leading: Icon(Icons.person, color: textColor),
            title: Text('Profile', style: TextStyle(color: textColor)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),

          // Statistics
          ListTile(
            leading: Icon(Icons.bar_chart, color: textColor),
            title: Text('Statistics', style: TextStyle(color: textColor)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StatsScreen()),
              );
            },
          ),

          Divider(),

          // Theme Switcher
          ListTile(
            leading: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: textColor,
            ),
            title: Text(
              isDark ? 'Light Mode' : 'Dark Mode',
              style: TextStyle(color: textColor),
            ),
            trailing: Switch(
              value: isDark,
              onChanged: (value) {
                themeController.toggleTheme();
              },
              activeColor: Color(0xFF3B82F6),
            ),
          ),

          Divider(),

          // Logout
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {
              authController.signOut();
            },
          ),

          // App Version
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Version 1.0.0',
              style: TextStyle(color: textColor.withOpacity(0.5), fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
