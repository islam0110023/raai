import 'package:raai/feature/auth/data/model/otp_verify_model/onboarding.dart';
import 'package:raai/feature/auth/data/model/otp_verify_model/tokens.dart';
import 'package:raai/feature/auth/domain/entity/otp_verify_entity.dart';

class OtpVerifyModel {
  factory OtpVerifyModel.fromJson(Map<String, dynamic> json) {
    return OtpVerifyModel(
      tokens: json['tokens'] == null
          ? null
          : Tokens.fromJson(json['tokens'] as Map<String, dynamic>),
      onboarding: json['onboarding'] == null
          ? null
          : Onboarding.fromJson(json['onboarding'] as Map<String, dynamic>),
    );
  }

  OtpVerifyModel({this.tokens, this.onboarding});
  Tokens? tokens;
  Onboarding? onboarding;

  Map<String, dynamic> toJson() => {
    'tokens': tokens?.toJson(),
    'onboarding': onboarding?.toJson(),
  };
  OtpVerifyEntity toEntity() {
    return OtpVerifyEntity(
      accessToken: tokens!.accessToken!,
      refreshToken: tokens!.refreshToken!,
    );
  }
}
