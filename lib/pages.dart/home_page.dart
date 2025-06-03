import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:zoozitest/l10n/app_localizations.dart';
import 'package:zoozitest/router/router/router.gr.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [WalletsRoute(), SettingRoute()],
      bottomNavigationBuilder: (_, tabsRouter) {
        return NavigationBar(
          selectedIndex: tabsRouter.activeIndex,
          onDestinationSelected: tabsRouter.setActiveIndex,
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.wallet_outlined),
              selectedIcon: Icon(Icons.wallet),
              label: AppLocalizations.of(context)!.wallets,
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: AppLocalizations.of(context)!.settings,
            ),
          ],
        );
      },
    );
  }
}
