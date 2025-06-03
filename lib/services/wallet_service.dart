import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:zoozitest/models/requests/transaction_request.dart';
import 'package:zoozitest/models/requests/wallet_request.dart';
import 'package:zoozitest/models/responses/transaction_response.dart';
import 'package:zoozitest/models/transaction.dart';
import 'package:zoozitest/models/wallet.dart';

part 'wallet_service.g.dart';

@RestApi()
abstract class WalletService {
  factory WalletService(Dio dio, {String baseUrl}) = _WalletService;

  @GET('/')
  Future<List<Wallet>> getWallets();

  @POST('/')
  Future<Wallet> createWallet({@Body() required WalletRequest body});

  @GET('/{walletId}')
  Future<Wallet> getWalletDetail({@Path('walletId') required int walletId});

  @POST('/{walletId}/transactions/deposit')
  Future<Transaction> createDepositTransaction({
    @Path('walletId') required int walletId,
    @Body() required TransactionRequest body,
  });

  @POST('/{walletId}/transactions/withdrawal')
  Future<Transaction> createWithdrawalTransaction({
    @Path('walletId') required int walletId,
    @Body() required TransactionRequest body,
  });

  @GET('/{walletId}/transactions')
  Future<TransactionResponse> getWalletTransactions({
    @Path('walletId') required int walletId,
    @Query('page') int page = 1,
    @Query('limit') int limit = 10,
  });
}
