import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:raai/app_bloc_observer.dart';
import 'package:raai/core/db/cache_helper/cache_helper.dart';
import 'package:raai/core/network/dio_helper.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/constants.dart';
import 'package:raai/core/utils/routes.dart';
import 'package:raai/core/utils/service_locator.dart';
import 'package:raai/feature/auth/presentation/manager/auth_cubit/auth_cubit.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  final WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);
  await EasyLocalization.ensureInitialized();
  setUpServices();
  DioHelper.init();
  await CacheHelper.init();
  Bloc.observer = AppBlocObserver();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar', ''), Locale('en', '')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar', ''),
      startLocale: const Locale('ar', ''),
      child: const Raai(),
    ),
  );
}

class Raai extends StatelessWidget {
  const Raai({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>()..checkAuth(),
      child: const AppRoot(),
    );
  }
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Raai',
        routerConfig: AppRoutes.route,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColor.white,
          primaryColor: AppColor.primaryNormal,
          datePickerTheme: const DatePickerThemeData(
            backgroundColor: AppColor.white,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColor.white,
            elevation: 0,
            centerTitle: true,
            surfaceTintColor: AppColor.white,
          ),
        ),
        builder: (context, child) {
          return BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              final ctx = navigatorKey.currentState!.overlay!.context;

              if (navigatorKey.currentState == null) return;

              if (state is AuthUnauthenticated) {
                if (Navigator.of(ctx, rootNavigator: true).canPop()) {
                  Navigator.of(ctx, rootNavigator: true).pop();
                }
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  GoRouter.of(ctx).go(AppRoutes.login);
                });
              }
              if (state is AuthLoading) {
                AppConstant.showLoadingDialog(ctx);
              }
            },
            child: child!,
          );
        },
      ),
    );
  }
}
