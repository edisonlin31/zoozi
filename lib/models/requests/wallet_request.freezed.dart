// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
WalletRequest _$WalletRequestFromJson(
  Map<String, dynamic> json
) {
    return _AuthRequest.fromJson(
      json
    );
}

/// @nodoc
mixin _$WalletRequest {

 String get currency; double get initialBalance;
/// Create a copy of WalletRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletRequestCopyWith<WalletRequest> get copyWith => _$WalletRequestCopyWithImpl<WalletRequest>(this as WalletRequest, _$identity);

  /// Serializes this WalletRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletRequest&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.initialBalance, initialBalance) || other.initialBalance == initialBalance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currency,initialBalance);

@override
String toString() {
  return 'WalletRequest(currency: $currency, initialBalance: $initialBalance)';
}


}

/// @nodoc
abstract mixin class $WalletRequestCopyWith<$Res>  {
  factory $WalletRequestCopyWith(WalletRequest value, $Res Function(WalletRequest) _then) = _$WalletRequestCopyWithImpl;
@useResult
$Res call({
 String currency, double initialBalance
});




}
/// @nodoc
class _$WalletRequestCopyWithImpl<$Res>
    implements $WalletRequestCopyWith<$Res> {
  _$WalletRequestCopyWithImpl(this._self, this._then);

  final WalletRequest _self;
  final $Res Function(WalletRequest) _then;

/// Create a copy of WalletRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currency = null,Object? initialBalance = null,}) {
  return _then(_self.copyWith(
currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,initialBalance: null == initialBalance ? _self.initialBalance : initialBalance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _AuthRequest extends WalletRequest {
   _AuthRequest({required this.currency, required this.initialBalance}): super._();
  factory _AuthRequest.fromJson(Map<String, dynamic> json) => _$AuthRequestFromJson(json);

@override final  String currency;
@override final  double initialBalance;

/// Create a copy of WalletRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthRequestCopyWith<_AuthRequest> get copyWith => __$AuthRequestCopyWithImpl<_AuthRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthRequest&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.initialBalance, initialBalance) || other.initialBalance == initialBalance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currency,initialBalance);

@override
String toString() {
  return 'WalletRequest(currency: $currency, initialBalance: $initialBalance)';
}


}

/// @nodoc
abstract mixin class _$AuthRequestCopyWith<$Res> implements $WalletRequestCopyWith<$Res> {
  factory _$AuthRequestCopyWith(_AuthRequest value, $Res Function(_AuthRequest) _then) = __$AuthRequestCopyWithImpl;
@override @useResult
$Res call({
 String currency, double initialBalance
});




}
/// @nodoc
class __$AuthRequestCopyWithImpl<$Res>
    implements _$AuthRequestCopyWith<$Res> {
  __$AuthRequestCopyWithImpl(this._self, this._then);

  final _AuthRequest _self;
  final $Res Function(_AuthRequest) _then;

/// Create a copy of WalletRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currency = null,Object? initialBalance = null,}) {
  return _then(_AuthRequest(
currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,initialBalance: null == initialBalance ? _self.initialBalance : initialBalance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
