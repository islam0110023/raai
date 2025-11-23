import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/feature/auth/presentation/view/forget_password_screen.dart';
import 'package:raai/feature/auth/presentation/view/login_screen.dart';
import 'package:raai/feature/auth/presentation/view/register_screen.dart';
import 'package:raai/feature/auth/presentation/view/reset_password_screen.dart';
import 'package:raai/feature/auth/presentation/view/select_role_screen.dart';
import 'package:raai/feature/auth/presentation/view/verify_o_t_p_screen.dart';
import 'package:raai/feature/medical_information/presentation/manager/medical_info_cubit.dart';
import 'package:raai/feature/medical_information/presentation/view/confirmation_screen.dart';
import 'package:raai/feature/medical_information/presentation/view/medical_information_screen.dart';
import 'package:raai/feature/onboarding/presentation/view/on_boarding_screen.dart';
import 'package:raai/feature/personal_info/presentation/view/personal_info_screen.dart';
import 'package:raai/feature/splash/presentation/view/splash_screen.dart';
import 'package:raai/main.dart';

class AppRoutes {
  AppRoutes._();

  static const splashScreen = '/';
  static const onBoarding = '/onboarding';
  static const login = '/login';
  static const register = '/register';
  static const verifyOTP = '/verify-otp';
  static const selectRole = '/select-role';
  static const forgetScreen = '/forget-password';
  static const resetPassword = '/reset-password';
  static const personalInfo = '/personal-info';
  static const medicalInfo = '/medical-info';
  static const confirmationScreen = '/confirmation-screen';

  static final route = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: splashScreen,
    routes: [
      GoRoute(
        path: splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: onBoarding,
        builder: (context, state) => const OnBoardingScreen(),
      ),
      GoRoute(path: login, builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: verifyOTP,
        builder: (context, state) => const VerifyOTPScreen(),
      ),
      GoRoute(
        path: selectRole,
        builder: (context, state) => const SelectRoleScreen(),
      ),
      GoRoute(
        path: forgetScreen,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
      GoRoute(
        path: resetPassword,
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      GoRoute(
        path: personalInfo,
        builder: (context, state) => const PersonalInfoScreen(),
      ),
      GoRoute(
        path: medicalInfo,
        builder: (context, state) => BlocProvider(
          create: (context) => MedicalInfoCubit(),
          child: const MedicalInformationScreen(),
        ),
      ),
      GoRoute(
        path: confirmationScreen,
        builder: (context, state) => const ConfirmationScreen(),
      ),
    ],
  );
}
