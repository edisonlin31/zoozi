import 'package:freezed_annotation/freezed_annotation.dart';
part 'auth_request.freezed.dart';
part 'auth_request.g.dart';

@freezed
abstract class AuthRequest with _$AuthRequest {
  const AuthRequest._();
  factory AuthRequest({
    required String email,
    required String password,
    @JsonKey(includeIfNull: false) String? name,
  }) = _AuthRequest;

  factory AuthRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => toJson();
}
