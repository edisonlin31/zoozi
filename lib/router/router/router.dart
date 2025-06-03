import 'package:auto_route/auto_route.dart';
import 'package:zoozitest/router/router/auth_guard.dart';
import 'package:zoozitest/router/router/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter({super.navigatorKey});

  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: '/login', page: LoginRoute.page),
    AutoRoute(path: '/register', page: RegisterRoute.page),
    AutoRoute(
      path: '/home',
      page: HomeRoute.page,
      initial: true,
      guards: [AuthGuard()],
      children: [
        AutoRoute(path: 'wallets', page: WalletsRoute.page),
        AutoRoute(path: 'settings', page: SettingRoute.page),
      ],
    ),
    AutoRoute(path: '/create-wallet', page: CreateWalletRoute.page),
    AutoRoute(path: '/wallet-detail', page: WalletDetailRoute.page),
    AutoRoute(
      path: '/wallet-detail/:walletId/transactions',
      page: TransactionsRoute.page,
    ),
    AutoRoute(path: '/create-transaction', page: CreateTransactionRoute.page),
  ];
}
