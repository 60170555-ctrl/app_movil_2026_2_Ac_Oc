import 'package:json_annotation/json_annotation.dart';

part 'token_pair.g.dart';

@JsonSerializable()
class TokenPair {
  final String accessToken;
  final String refreshToken;

  TokenPair({required this.accessToken, required this.refreshToken});

  factory TokenPair.fromJson(Map<String, dynamic> json) => _$TokenPairFromJson(json);
  Map<String, dynamic> toJson() => _$TokenPairToJson(this);
}
