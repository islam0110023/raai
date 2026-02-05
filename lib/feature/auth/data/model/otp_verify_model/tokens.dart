import 'package:raai/feature/auth/domain/entity/otp_verify_entity.dart';

class Tokens {
  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
    tokenType: json['tokenType'] as String?,
    accessToken: json['accessToken'] as String?,
    refreshToken: json['refreshToken'] as String?,
    expiresIn: json['expiresIn'] as int?,
  );

  Tokens({this.tokenType, this.accessToken, this.refreshToken, this.expiresIn});
  String? tokenType;
  String? accessToken;
  String? refreshToken;
  int? expiresIn;

  Map<String, dynamic> toJson() => {
    'tokenType': tokenType,
    'accessToken': accessToken,
    'refreshToken': refreshToken,
    'expiresIn': expiresIn,
  };
  OtpVerifyEntity toEntity() {
    return OtpVerifyEntity(
      accessToken: accessToken!,
      refreshToken: refreshToken!,
    );
  }
}
