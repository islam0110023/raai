import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/core/utils/service_locator.dart';
import 'package:raai/feature/add_reads/presentation/manager/add_read/add_reading_cubit.dart';
import 'package:raai/feature/add_reads/presentation/manager/add_reads_cubit.dart';
import 'package:raai/feature/add_reads/presentation/view/add_reads_screen.dart';
import 'package:raai/feature/auth/presentation/manager/login/login_cubit.dart';
import 'package:raai/feature/auth/presentation/manager/new_password/new_password_cubit.dart';
import 'package:raai/feature/auth/presentation/manager/otp_register/otp_register_cubit.dart';
import 'package:raai/feature/auth/presentation/manager/register/register_cubit.dart';
import 'package:raai/feature/auth/presentation/manager/reset/reset_cubit.dart';
import 'package:raai/feature/auth/presentation/manager/select_role/select_role_cubit.dart';
import 'package:raai/feature/auth/presentation/view/forget_password_screen.dart';
import 'package:raai/feature/auth/presentation/view/login_screen.dart';
import 'package:raai/feature/auth/presentation/view/register_screen.dart';
import 'package:raai/feature/auth/presentation/view/reset_password_screen.dart';
import 'package:raai/feature/auth/presentation/view/select_role_screen.dart';
import 'package:raai/feature/auth/presentation/view/verify_o_t_p_screen.dart';
import 'package:raai/feature/bottom_nav/presentation/manager/bottom_nav_cubit.dart';
import 'package:raai/feature/bottom_nav/presentation/manager/voice_cubit/voice_cubit.dart';
import 'package:raai/feature/bottom_nav/presentation/view/coming_soon.dart';
import 'package:raai/feature/bottom_nav/presentation/view/home_screen.dart';
import 'package:raai/feature/caregiver/connect_elder_caregiver/presentation/manager/connect_elder_caregiver/connect_elder_caregiver_cubit.dart';
import 'package:raai/feature/caregiver/connect_elder_caregiver/presentation/view/connect_elder_caregiver_screen.dart';
import 'package:raai/feature/caregiver/home_caregiver/presentation/manager/bottom_nav_caregiver_cubit.dart';
import 'package:raai/feature/caregiver/home_caregiver/presentation/view/bottom_nav_bar_caregiver.dart';
import 'package:raai/feature/caregivers/presentation/manager/caregiver_list/caregiver_list_cubit.dart';
import 'package:raai/feature/caregivers/presentation/view/add_caregiver_screen.dart';
import 'package:raai/feature/caregivers/presentation/view/caregivers_list_screen.dart';
import 'package:raai/feature/chat_bot/presentation/manager/chat_bot_cubit.dart';
import 'package:raai/feature/medical_information/presentation/manager/medical_info_cubit.dart';
import 'package:raai/feature/medical_information/presentation/view/confirmation_screen.dart';
import 'package:raai/feature/medical_information/presentation/view/medical_information_screen.dart';
import 'package:raai/feature/medication/presenation/manager/add_medication/add_medication_cubit.dart';
import 'package:raai/feature/medication/presenation/manager/medication_form_cubit.dart';
import 'package:raai/feature/medication/presenation/view/add_medication_screen.dart';
import 'package:raai/feature/models/presentation/manager/sugar_daily/sugar_daily_cubit.dart';
import 'package:raai/feature/models/presentation/manager/sugar_monthly/sugar_monthly_cubit.dart';
import 'package:raai/feature/models/presentation/view/select_models_screen.dart';
import 'package:raai/feature/models/presentation/view/sugar_daily_model_screen.dart';
import 'package:raai/feature/models/presentation/view/sugar_monthly_model_screen.dart';
import 'package:raai/feature/notification/presentation/view/notification_screen.dart';
import 'package:raai/feature/onboarding/presentation/view/on_boarding_screen.dart';
import 'package:raai/feature/personal_info/presentation/manager/personal_cubit.dart';
import 'package:raai/feature/personal_info/presentation/view/personal_info_screen.dart';
import 'package:raai/feature/profile/presentation/manager/profile/profile_cubit.dart';
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
  static const homeScreen = '/home-screen';
  static const addReads = '/add-reads';
  static const selectModels = '/select-models';
  static const sugarMonthlyModel = '/sugar-monthly-model';
  static const sugarDailyModel = '/sugar-daily-model';
  static const camingSoon = '/coming-soon';
  static const notificationScreen = '/notification-screen';
  static const caregiverList = '/caregiver-list';
  static const addCaregiver = '/add-caregiver';
  static const addMedication = '/add-medication';
  static const homeScreenCaregiver = '/home-screen-caregiver';
  static const connectElderCaregiver = '/connect-elder-caregiver';

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
      GoRoute(
        path: login,
        builder: (context, state) => BlocProvider(
          create: (context) => LoginCubit(getIt()),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => BlocProvider(
          create: (context) => RegisterCubit(getIt()),
          child: const RegisterScreen(),
        ),
      ),
      GoRoute(
        path: verifyOTP,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final email = extra['email'];
          return BlocProvider(
            create: (context) => OtpRegisterCubit(getIt(), email, getIt()),
            child: const VerifyOTPScreen(),
          );
        },
      ),
      GoRoute(
        path: selectRole,
        builder: (context, state) => BlocProvider(
          create: (context) => SelectRoleCubit(getIt()),
          child: const SelectRoleScreen(),
        ),
      ),
      GoRoute(
        path: forgetScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => ResetCubit(getIt()),
          child: const ForgetPasswordScreen(),
        ),
      ),
      GoRoute(
        path: resetPassword,
        builder: (context, state) => BlocProvider(
          create: (context) => NewPasswordCubit(getIt()),
          child: const ResetPasswordScreen(),
        ),
      ),
      GoRoute(
        path: personalInfo,
        builder: (context, state) => BlocProvider(
          create: (context) => PersonalCubit(getIt()),
          child: const PersonalInfoScreen(),
        ),
      ),
      GoRoute(
        path: medicalInfo,
        builder: (context, state) => BlocProvider(
          create: (context) => MedicalInfoCubit(getIt()),
          child: const MedicalInformationScreen(),
        ),
      ),
      GoRoute(
        path: confirmationScreen,
        builder: (context, state) => const ConfirmationScreen(),
      ),
      GoRoute(
        path: homeScreen,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => BottomNavCubit()),
            BlocProvider(create: (context) => ChatBotCubit(getIt())),
            BlocProvider(create: (context) => VoiceAssistantCubit(getIt())),
            BlocProvider(
              create: (context) => ProfileCubit(getIt())..getUserProfile(),
            ),
          ],
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        path: addReads,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AddReadingCubit(getIt(), getIt()),
            ),
            BlocProvider(
              create: (context) => AddReadsCubit(state.extra as bool),
            ),
          ],
          child: const AddReadsScreen(),
        ),
      ),
      GoRoute(
        path: selectModels,
        builder: (context, state) => const SelectModelsScreen(),
      ),
      GoRoute(
        path: sugarMonthlyModel,
        builder: (context, state) => BlocProvider(
          create: (context) => SugarMonthlyCubit(getIt()),
          child: const SugarMonthlyModelScreen(),
        ),
      ),
      GoRoute(
        path: sugarDailyModel,
        builder: (context, state) => BlocProvider(
          create: (context) => SugarDailyCubit(getIt()),
          child: const SugarDailyModelScreen(),
        ),
      ),
      GoRoute(
        path: camingSoon,
        builder: (context, state) => const ComingSoon(),
      ),
      GoRoute(
        path: notificationScreen,
        builder: (context, state) => const NotificationScreen(),
      ),
      GoRoute(
        path: caregiverList,
        builder: (context, state) => BlocProvider(
          create: (context) => CaregiverListCubit(getIt()),
          child: const CaregiversListScreen(),
        ),
      ),
      GoRoute(
        path: addCaregiver,
        builder: (context, state) => const AddCaregiverScreen(),
      ),
      GoRoute(
        path: addMedication,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => MedicationFormCubit()),
            BlocProvider(create: (context) => AddMedicationCubit(getIt())),
          ],
          child: const AddMedicationScreen(),
        ),
      ),
      GoRoute(
        path: homeScreenCaregiver,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => BottomNavCaregiverCubit()),
          ],
          child: const BottomNavBarCaregiver(),
        ),
      ),
      GoRoute(
        path: connectElderCaregiver,
        builder: (context, state) => BlocProvider(
          create: (context) => ConnectElderCaregiverCubit(getIt()),
          child: const ConnectElderCaregiverScreen(),
        ),
      ),
    ],
  );
}
