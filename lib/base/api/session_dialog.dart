import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:zoozitest/base/utils/cache_manager.dart';
import 'package:zoozitest/router/router/router.gr.dart';

class SessionDialogManager {
  static bool _isDialogShown = false;

  static void showSessionExpiredDialog(BuildContext context) {
    if (_isDialogShown) return;
    _isDialogShown = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Session Expired'),
          content: const Text('Your session has expired. Please log in again.'),
          actions: [
            TextButton(
              onPressed: () {
                CacheManager.remove(CacheConstants.accessToken);
                context.router.replaceAll([const LoginRoute()]);
                _isDialogShown = false;
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    ).then((_) {
      _isDialogShown = false;
    });
  }
}
