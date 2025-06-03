import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoozitest/base/utils/cache_manager.dart';
import 'package:zoozitest/base/utils/colors.dart';
import 'package:zoozitest/controllers/language_controller.dart';
import 'package:zoozitest/controllers/theme_controller.dart';
import 'package:zoozitest/l10n/app_localizations.dart';
import 'package:zoozitest/router/router/router.gr.dart';

@RoutePage()
class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  _showThemeDialog(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.brightness_auto),
                title: Text(AppLocalizations.of(context)!.systemDefault),
                onTap: () {
                  ref.read(themeProvider.notifier).setTheme(ThemeMode.system);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.light_mode),
                title: Text(AppLocalizations.of(context)!.lightMode),
                onTap: () {
                  ref.read(themeProvider.notifier).setTheme(ThemeMode.light);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.dark_mode),
                title: Text(AppLocalizations.of(context)!.darkMode),
                onTap: () {
                  ref.read(themeProvider.notifier).setTheme(ThemeMode.dark);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  _showLanguageDialog(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.language),
                  title: Text(AppLocalizations.of(context)!.systemDefault),
                  onTap: () {
                    ref
                        .read(languageProvider.notifier)
                        .setLanguage(const Locale('system'));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: Text(AppLocalizations.of(context)!.english),
                  onTap: () {
                    ref
                        .read(languageProvider.notifier)
                        .setLanguage(const Locale('en'));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: Text(AppLocalizations.of(context)!.indonesian),
                  onTap: () {
                    ref
                        .read(languageProvider.notifier)
                        .setLanguage(const Locale('id'));
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.logoutConfirmationTitle),
          content: Text(
            AppLocalizations.of(context)!.logoutConfirmationMessage,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () async {
                await CacheManager.remove(CacheConstants.accessToken);
                Navigator.of(context).pop();
                context.router.replaceAll([const LoginRoute()]);
              },
              child: Text(AppLocalizations.of(context)!.confirm),
            ),
          ],
        );
      },
    );
  }

  Widget buildMenuTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      minVerticalPadding: 0,
      dense: true,
      minTileHeight: 40,
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final locale = ref.watch(languageProvider);
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.settings)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.background(context),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildMenuTile(
                  icon: Icons.brightness_6,
                  title: AppLocalizations.of(context)!.changeTheme,
                  subtitle: themeMode == ThemeMode.system
                      ? AppLocalizations.of(context)!.systemDefault
                      : themeMode == ThemeMode.light
                      ? AppLocalizations.of(context)!.lightMode
                      : AppLocalizations.of(context)!.darkMode,
                  onTap: () => _showThemeDialog(context, ref),
                ),
                const Divider(),
                buildMenuTile(
                  icon: Icons.language,
                  title: AppLocalizations.of(context)!.changeLanguage,
                  subtitle: locale.languageCode == 'en'
                      ? AppLocalizations.of(context)!.english
                      : locale.languageCode == 'id'
                      ? AppLocalizations.of(context)!.indonesian
                      : AppLocalizations.of(context)!.systemDefault,
                  onTap: () => _showLanguageDialog(context, ref),
                ),
                const Divider(),
                buildMenuTile(
                  icon: Icons.logout,
                  title: AppLocalizations.of(context)!.logout,
                  subtitle: AppLocalizations.of(context)!.logoutDescription,
                  onTap: () => _showLogoutDialog(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
