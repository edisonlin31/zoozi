import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(valueField: 'type')
enum TransactionType {
  @JsonValue('DEPOSIT')
  deposit,
  @JsonValue('WITHDRAWAL')
  withdrawal,
}
