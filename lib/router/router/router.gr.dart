// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;
import 'package:zoozitest/models/enums/transaction_type.dart' as _i12;
import 'package:zoozitest/pages.dart/create_transaction_page.dart' as _i1;
import 'package:zoozitest/pages.dart/create_wallet_page.dart' as _i2;
import 'package:zoozitest/pages.dart/home_page.dart' as _i3;
import 'package:zoozitest/pages.dart/login_page.dart' as _i4;
import 'package:zoozitest/pages.dart/register_page.dart' as _i5;
import 'package:zoozitest/pages.dart/setting_page.dart' as _i6;
import 'package:zoozitest/pages.dart/transactions_page.dart' as _i7;
import 'package:zoozitest/pages.dart/wallet_detail_page.dart' as _i8;
import 'package:zoozitest/pages.dart/wallets_page.dart' as _i9;

/// generated route for
/// [_i1.CreateTransactionPage]
class CreateTransactionRoute
    extends _i10.PageRouteInfo<CreateTransactionRouteArgs> {
  CreateTransactionRoute({
    _i11.Key? key,
    required int walletId,
    required _i12.TransactionType transactionType,
    List<_i10.PageRouteInfo>? children,
  }) : super(
         CreateTransactionRoute.name,
         args: CreateTransactionRouteArgs(
           key: key,
           walletId: walletId,
           transactionType: transactionType,
         ),
         initialChildren: children,
       );

  static const String name = 'CreateTransactionRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateTransactionRouteArgs>();
      return _i1.CreateTransactionPage(
        key: args.key,
        walletId: args.walletId,
        transactionType: args.transactionType,
      );
    },
  );
}

class CreateTransactionRouteArgs {
  const CreateTransactionRouteArgs({
    this.key,
    required this.walletId,
    required this.transactionType,
  });

  final _i11.Key? key;

  final int walletId;

  final _i12.TransactionType transactionType;

  @override
  String toString() {
    return 'CreateTransactionRouteArgs{key: $key, walletId: $walletId, transactionType: $transactionType}';
  }
}

/// generated route for
/// [_i2.CreateWalletPage]
class CreateWalletRoute extends _i10.PageRouteInfo<void> {
  const CreateWalletRoute({List<_i10.PageRouteInfo>? children})
    : super(CreateWalletRoute.name, initialChildren: children);

  static const String name = 'CreateWalletRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i2.CreateWalletPage();
    },
  );
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute({List<_i10.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomePage();
    },
  );
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i10.PageRouteInfo<void> {
  const LoginRoute({List<_i10.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i4.LoginPage();
    },
  );
}

/// generated route for
/// [_i5.RegisterPage]
class RegisterRoute extends _i10.PageRouteInfo<void> {
  const RegisterRoute({List<_i10.PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i5.RegisterPage();
    },
  );
}

/// generated route for
/// [_i6.SettingPage]
class SettingRoute extends _i10.PageRouteInfo<void> {
  const SettingRoute({List<_i10.PageRouteInfo>? children})
    : super(SettingRoute.name, initialChildren: children);

  static const String name = 'SettingRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i6.SettingPage();
    },
  );
}

/// generated route for
/// [_i7.TransactionsPage]
class TransactionsRoute extends _i10.PageRouteInfo<TransactionsRouteArgs> {
  TransactionsRoute({
    _i11.Key? key,
    required int walletId,
    List<_i10.PageRouteInfo>? children,
  }) : super(
         TransactionsRoute.name,
         args: TransactionsRouteArgs(key: key, walletId: walletId),
         initialChildren: children,
       );

  static const String name = 'TransactionsRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TransactionsRouteArgs>();
      return _i7.TransactionsPage(key: args.key, walletId: args.walletId);
    },
  );
}

class TransactionsRouteArgs {
  const TransactionsRouteArgs({this.key, required this.walletId});

  final _i11.Key? key;

  final int walletId;

  @override
  String toString() {
    return 'TransactionsRouteArgs{key: $key, walletId: $walletId}';
  }
}

/// generated route for
/// [_i8.WalletDetailPage]
class WalletDetailRoute extends _i10.PageRouteInfo<WalletDetailRouteArgs> {
  WalletDetailRoute({
    _i11.Key? key,
    required int walletId,
    List<_i10.PageRouteInfo>? children,
  }) : super(
         WalletDetailRoute.name,
         args: WalletDetailRouteArgs(key: key, walletId: walletId),
         initialChildren: children,
       );

  static const String name = 'WalletDetailRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WalletDetailRouteArgs>();
      return _i8.WalletDetailPage(key: args.key, walletId: args.walletId);
    },
  );
}

class WalletDetailRouteArgs {
  const WalletDetailRouteArgs({this.key, required this.walletId});

  final _i11.Key? key;

  final int walletId;

  @override
  String toString() {
    return 'WalletDetailRouteArgs{key: $key, walletId: $walletId}';
  }
}

/// generated route for
/// [_i9.WalletsPage]
class WalletsRoute extends _i10.PageRouteInfo<void> {
  const WalletsRoute({List<_i10.PageRouteInfo>? children})
    : super(WalletsRoute.name, initialChildren: children);

  static const String name = 'WalletsRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i9.WalletsPage();
    },
  );
}
