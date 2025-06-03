import 'package:auto_route/auto_route.dart';
import 'package:zoozitest/base/utils/cache_manager.dart';
import 'package:zoozitest/router/router/router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final token = await CacheManager.retrieve(CacheConstants.accessToken);
    if (token != null && token.isNotEmpty) {
      resolver.next(true);
    } else {
      router.replace(const LoginRoute());
    }
  }
}
