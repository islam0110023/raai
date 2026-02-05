import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:raai/core/model/api_response.dart';
import 'package:raai/core/network/dio_end_piont.dart';
import 'package:raai/core/network/dio_helper.dart';
import 'package:raai/feature/auth/data/model/otp_verify_model/otp_verify_model.dart';
import 'package:raai/feature/auth/data/model/otp_verify_model/reset_data.dart';
import 'package:raai/feature/auth/data/model/otp_verify_model/tokens.dart';
import 'package:raai/feature/auth/domain/entity/login_entity.dart';
import 'package:raai/feature/auth/domain/entity/otp_reset_entity.dart';
import 'package:raai/feature/auth/domain/entity/otp_verify_entity.dart';
import 'package:raai/feature/auth/domain/entity/reset_entity.dart';
import 'package:raai/feature/auth/domain/entity/select_role_entity.dart';

abstract class AuthRemoteDataSource {
  Future<Unit> register({
    required String email,
    required String phone,
    required String password,
  });
  Future<OtpVerifyEntity> otpVerify({
    required String email,
    required String otp,
  });
  Future<OtpVerifyEntity> refreshAccessToken({required String refreshToken});
  Future<LoginEntity> login({required String email, required String password});
  Future<ResetEntity> resetPass({required String email});
  Future<OtpResetEntity> otpReset({
    required int resetRequestId,
    required String otp,
  });
  Future<Unit> newPassword({
    required String resetToken,
    required String password,
  });
  Future<SelectRoleEntity> selectRole({required String role});
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  @override
  Future<Unit> register({
    required String email,
    required String phone,
    required String password,
  }) async {
    await DioHelper.postData(
      url: Endpoints.register,
      data: {'email': email, 'phone': phone, 'password': password},
      options: Options(extra: {'skipAuth': true}),
    );
    return unit;
  }

  @override
  Future<OtpVerifyEntity> otpVerify({
    required String email,
    required String otp,
  }) async {
    final response = await DioHelper.postData(
      url: Endpoints.otpVerify,
      data: {'email': email, 'otp': otp},
      options: Options(extra: {'skipAuth': true}),
    );
    final data = ApiResponse<OtpVerifyModel>.fromJson(
      response.data,
      fromJsonT: (json) => OtpVerifyModel.fromJson(json),
    );
    return data.data!.toEntity();
  }

  @override
  Future<OtpVerifyEntity> refreshAccessToken({
    required String refreshToken,
  }) async {
    final response = await DioHelper.postData(
      url: Endpoints.refreshAccessToken,
      data: {'refreshToken': refreshToken},
      options: Options(extra: {'skipAuth': true}),
    );
    final data = ApiResponse<Tokens>.fromJson(
      response.data,
      fromJsonT: (json) => Tokens.fromJson(json['tokens']),
    );
    return data.data!.toEntity();
  }

  @override
  Future<LoginEntity> login({
    required String email,
    required String password,
  }) async {
    final response = await DioHelper.postData(
      url: Endpoints.login,
      data: {'identifier': email, 'password': password},
      options: Options(extra: {'skipAuth': true}),
    );
    final data = ApiResponse<Tokens>.fromJson(
      response.data,
      fromJsonT: (json) => Tokens.fromJson(json['tokens']),
    );
    return LoginEntity(
      accessToken: data.data!.accessToken!,
      refreshToken: data.data!.refreshToken!,
      statusCode: data.statusCode,
      appCode: data.appCode!,
      statusMessage: data.statusMessage,
      message: data.message!,
    );
  }

  @override
  Future<ResetEntity> resetPass({required String email}) async {
    final response = await DioHelper.postData(
      url: Endpoints.resetPass,
      data: {'email': email},
      options: Options(extra: {'skipAuth': true}),
    );
    final data = ApiResponse<ResetData>.fromJson(
      response.data,
      fromJsonT: (json) => ResetData.fromJson(json),
    );
    return ResetEntity(
      resetRequestId: data.data?.resetRequestId,
      statusCode: data.statusCode,
      appCode: data.appCode!,
      statusMessage: data.statusMessage,
      message: data.message!,
    );
  }

  @override
  Future<OtpResetEntity> otpReset({
    required int resetRequestId,
    required String otp,
  }) async {
    final response = await DioHelper.postData(
      url: Endpoints.otpReset,
      data: {'resetRequestId': resetRequestId, 'otp': otp},
      options: Options(extra: {'skipAuth': true}),
    );
    final data = ApiResponse.fromJson(response.data);
    return OtpResetEntity(
      resetToken: response.data['data']['resetToken'],
      statusCode: data.statusCode,
      appCode: data.appCode!,
      statusMessage: data.statusMessage,
      message: data.message!,
    );
  }

  @override
  Future<Unit> newPassword({
    required String resetToken,
    required String password,
  }) async {
    await DioHelper.postData(
      url: Endpoints.newPassword,
      data: {'resetToken': resetToken, 'newPassword': password},
      options: Options(extra: {'skipAuth': true}),
    );
    return unit;
  }

  @override
  Future<SelectRoleEntity> selectRole({required String role}) async {
    final response = await DioHelper.postData(
      url: Endpoints.selectRole,
      data: {'role': role},
    );
    final data = ApiResponse.fromJson(response.data);

    return SelectRoleEntity(
      statusCode: data.statusCode,
      appCode: data.appCode!,
      statusMessage: data.statusMessage,
      message: data.message!,
    );
  }
}
