import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:zoozitest/models/requests/auth_request.dart';

part 'auth_service.g.dart';

@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST('/register')
  Future<dynamic> register({@Body() required AuthRequest body});

  @POST('/login')
  Future<dynamic> login({@Body() required AuthRequest body});
}
