import 'package:get_it/get_it.dart';
import 'package:raai/core/services/internet_services.dart';
import 'package:raai/core/services/token_manager.dart';
import 'package:raai/feature/add_reads/data/data_source/add_read_remote_data_source.dart';
import 'package:raai/feature/add_reads/data/repo/add_read_repo_impl.dart';
import 'package:raai/feature/add_reads/domain/repo/add_read_repo.dart';
import 'package:raai/feature/add_reads/domain/use_case/add_blood_use_case.dart';
import 'package:raai/feature/add_reads/domain/use_case/add_sugar_use_case.dart';
import 'package:raai/feature/auth/data/data_source/auth_remote_data_source.dart';
import 'package:raai/feature/auth/data/repo/auth_repo_impl.dart';
import 'package:raai/feature/auth/domain/repo/auth_repo.dart';
import 'package:raai/feature/auth/domain/use_case/login_use_case.dart';
import 'package:raai/feature/auth/domain/use_case/new_password_use_case.dart';
import 'package:raai/feature/auth/domain/use_case/otp_reset_use_case.dart';
import 'package:raai/feature/auth/domain/use_case/otp_verify_use_case.dart';
import 'package:raai/feature/auth/domain/use_case/refresh_access_token_use_case.dart';
import 'package:raai/feature/auth/domain/use_case/register_use_case.dart';
import 'package:raai/feature/auth/domain/use_case/reset_pass_use_case.dart';
import 'package:raai/feature/auth/domain/use_case/select_role_use_case.dart';
import 'package:raai/feature/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:raai/feature/bottom_nav/data/data_source/voice_remote_data_source.dart';
import 'package:raai/feature/bottom_nav/data/repo/voice_repo_impl.dart';
import 'package:raai/feature/bottom_nav/domain/repo/voice_repo.dart';
import 'package:raai/feature/bottom_nav/domain/use_case/analyze_voice_use_case.dart';
import 'package:raai/feature/caregiver/all_medication_caregiver/data/data_source/all_medication_caregiver_remote_data_source.dart';
import 'package:raai/feature/caregiver/all_medication_caregiver/data/repo/all_medication_caregiver_repo_impl.dart';
import 'package:raai/feature/caregiver/all_medication_caregiver/domain/repo/all_medication_caregiver_repo.dart';
import 'package:raai/feature/caregiver/all_medication_caregiver/domain/use_case/get_all_medication_in_caregiver_use_case.dart';
import 'package:raai/feature/caregiver/connect_elder_caregiver/data/data_source/connect_elder_caregiver_remote_data_source.dart';
import 'package:raai/feature/caregiver/connect_elder_caregiver/data/repo/connect_elder_caregiver_repo_impl.dart';
import 'package:raai/feature/caregiver/connect_elder_caregiver/domain/repo/connect_elder_caregiver_repo.dart';
import 'package:raai/feature/caregiver/connect_elder_caregiver/domain/use_case/connect_caregiver_with_elder_use_case.dart';
import 'package:raai/feature/caregiver/home_caregiver/data/data_source/home_caregiver_remote_data_source.dart';
import 'package:raai/feature/caregiver/home_caregiver/data/repo/home_caregiver_repo_impl.dart';
import 'package:raai/feature/caregiver/home_caregiver/domain/repo/home_caregiver_repo.dart';
import 'package:raai/feature/caregiver/home_caregiver/domain/use_case/get_home_caregiver_data_use_case.dart';
import 'package:raai/feature/caregiver/profile_caregiver/data/data_source/profile_caregiver_remote_data_source.dart';
import 'package:raai/feature/caregiver/profile_caregiver/data/repo/profile_caregiver_repo_impl.dart';
import 'package:raai/feature/caregiver/profile_caregiver/domain/repo/profile_caregiver_repo.dart';
import 'package:raai/feature/caregiver/profile_caregiver/domain/use_case/get_profile_caregiver_data_use_case.dart';
import 'package:raai/feature/caregivers/data/data_source/caregiver_remote_data_source.dart';
import 'package:raai/feature/caregivers/data/repo/caregiver_repo_impl.dart';
import 'package:raai/feature/caregivers/domain/repo/caregiver_repo.dart';
import 'package:raai/feature/caregivers/domain/use_case/get_caregiver_list_use_case.dart';
import 'package:raai/feature/chat_bot/data/data_source/chat_bot_remote_data_source.dart';
import 'package:raai/feature/chat_bot/data/repo/chat_bot_repo_impl.dart';
import 'package:raai/feature/chat_bot/domain/repo/chat_bot_repo.dart';
import 'package:raai/feature/chat_bot/domain/use_case/get_messages_use_case.dart';
import 'package:raai/feature/home/data/data_source/home_remote_data_source.dart';
import 'package:raai/feature/home/data/repo/home_repo_impl.dart';
import 'package:raai/feature/home/domain/repo/home_repo.dart';
import 'package:raai/feature/home/domain/use_case/get_home_data_use_case.dart';
import 'package:raai/feature/medical_information/data/data_source/medical_remote_data_source.dart';
import 'package:raai/feature/medical_information/data/repo/medical_repo_impl.dart';
import 'package:raai/feature/medical_information/domain/repo/medical_repo.dart';
import 'package:raai/feature/medical_information/domain/use_case/set_medical_use_case.dart';
import 'package:raai/feature/medication/data/data_source/medication_remote_data_source.dart';
import 'package:raai/feature/medication/data/repo/medication_repo_impl.dart';
import 'package:raai/feature/medication/domain/repo/medication_repo.dart';
import 'package:raai/feature/medication/domain/use_case/create_medication_use_case.dart';
import 'package:raai/feature/medication/domain/use_case/do_not_remember_use_case.dart';
import 'package:raai/feature/medication/domain/use_case/get_medications_use_case.dart';
import 'package:raai/feature/medication/domain/use_case/snooze_medication_use_case.dart';
import 'package:raai/feature/medication/domain/use_case/tablet_model_use_case.dart';
import 'package:raai/feature/medication/domain/use_case/take_medication_use_case.dart';
import 'package:raai/feature/models/data/data_source/model_remote_data_source.dart';
import 'package:raai/feature/models/data/repo/model_repo_impl.dart';
import 'package:raai/feature/models/domain/repo/model_repo.dart';
import 'package:raai/feature/models/domain/use_case/get_sugar_daily_use_case.dart';
import 'package:raai/feature/models/domain/use_case/get_sugar_monthly_use_case.dart';
import 'package:raai/feature/personal_info/data/data_source/personal_remote_data_source.dart';
import 'package:raai/feature/personal_info/data/repo/personal_repo_impl.dart';
import 'package:raai/feature/personal_info/domain/repo/personal_repo.dart';
import 'package:raai/feature/personal_info/domain/use_case/set_personal_info_use_case.dart';
import 'package:raai/feature/profile/data/data_source/profile_remote_data_source.dart';
import 'package:raai/feature/profile/data/repo/profile_repo_impl.dart';
import 'package:raai/feature/profile/domain/repo/profile_repo.dart';
import 'package:raai/feature/profile/domain/use_case/get_user_profile_use_case.dart';
import 'package:raai/feature/reads/data/data_source/read_remote_data_source.dart';
import 'package:raai/feature/reads/data/repo/read_repo_impl.dart';
import 'package:raai/feature/reads/domain/repo/read_repo.dart';
import 'package:raai/feature/reads/domain/use_case/get_blood_reads_use_case.dart';
import 'package:raai/feature/reads/domain/use_case/get_sugar_reads_use_case.dart';
import 'package:raai/feature/reads/domain/use_case/update_blood_use_case.dart';
import 'package:raai/feature/reads/domain/use_case/update_sugar_use_case.dart';

final getIt = GetIt.instance;
void setUpServices() {
  getIt.registerLazySingleton<InternetService>(() => InternetService());
  getIt.registerLazySingleton<TokenManager>(() => TokenManager());
  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit(getIt()));

  //Data Source
  getIt.registerLazySingleton<ChatBotRemoteDataSource>(
    () => ChatBotRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<PersonalRemoteDataSource>(
    () => PersonalRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<MedicalRemoteDataSource>(
    () => MedicalRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<AddReadRemoteDataSource>(
    () => AddReadRemoteDataSourceImpl(),
  );

  getIt.registerLazySingleton<ReadRemoteDataSource>(
    () => ReadRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<ModelRemoteDataSource>(
    () => ModelRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<MedicationRemoteDataSource>(
    () => MedicationRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<VoiceRemoteDataSource>(
    () => VoiceRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<HomeCaregiverRemoteDataSource>(
    () => HomeCaregiverRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<ProfileCaregiverRemoteDataSource>(
    () => ProfileCaregiverRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<ConnectElderCaregiverRemoteDataSource>(
    () => ConnectElderCaregiverRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<CaregiverRemoteDataSource>(
    () => CaregiverRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<AllMedicationCaregiverRemoteDataSource>(
    () => AllMedicationCaregiverRemoteDataSourceImpl(),
  );

  //Repo
  getIt.registerLazySingleton<ChatBotRepo>(() => ChatBotRepoImpl(getIt()));

  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(getIt()));
  getIt.registerLazySingleton<PersonalRepo>(() => PersonalRepoImpl(getIt()));
  getIt.registerLazySingleton<MedicalRepo>(() => MedicalRepoImpl(getIt()));
  getIt.registerLazySingleton<AddReadRepo>(() => AddReadRepoImpl(getIt()));
  getIt.registerLazySingleton<ReadRepo>(() => ReadRepoImpl(getIt()));
  getIt.registerLazySingleton<ModelRepo>(() => ModelRepoImpl(getIt()));
  getIt.registerLazySingleton<ProfileRepo>(() => ProfileRepoImpl(getIt()));
  getIt.registerLazySingleton<MedicationRepo>(
    () => MedicationRepoImpl(getIt()),
  );
  getIt.registerLazySingleton<VoiceRepo>(() => VoiceRepoImpl(getIt()));
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepoImpl(getIt()));
  getIt.registerLazySingleton<HomeCaregiverRepo>(
    () => HomeCaregiverRepoImpl(getIt()),
  );
  getIt.registerLazySingleton<ProfileCaregiverRepo>(
    () => ProfileCaregiverRepoImpl(getIt()),
  );
  getIt.registerLazySingleton<ConnectElderCaregiverRepo>(
    () => ConnectElderCaregiverRepoImpl(getIt()),
  );
  getIt.registerLazySingleton<CaregiverRepo>(() => CaregiverRepoImpl(getIt()));
  getIt.registerLazySingleton<AllMedicationCaregiverRepo>(
    () => AllMedicationCaregiverRepoImpl(getIt()),
  );

  //UseCase
  getIt.registerLazySingleton<GetMessagesUseCase>(
    () => GetMessagesUseCase(getIt()),
  );

  getIt.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(getIt()));
  getIt.registerLazySingleton<OtpVerifyUseCase>(
    () => OtpVerifyUseCase(getIt()),
  );
  getIt.registerLazySingleton<RefreshAccessTokenUseCase>(
    () => RefreshAccessTokenUseCase(getIt()),
  );
  getIt.registerLazySingleton<LoginUseCase>(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton<ResetPassUseCase>(
    () => ResetPassUseCase(getIt()),
  );
  getIt.registerLazySingleton<OtpResetUseCase>(() => OtpResetUseCase(getIt()));
  getIt.registerLazySingleton<NewPasswordUseCase>(
    () => NewPasswordUseCase(getIt()),
  );
  getIt.registerLazySingleton<SetPersonalInfoUseCase>(
    () => SetPersonalInfoUseCase(getIt()),
  );
  getIt.registerLazySingleton<SelectRoleUseCase>(
    () => SelectRoleUseCase(getIt()),
  );
  getIt.registerLazySingleton<SetMedicalUseCase>(
    () => SetMedicalUseCase(getIt()),
  );
  getIt.registerLazySingleton<AddSugarUseCase>(() => AddSugarUseCase(getIt()));
  getIt.registerLazySingleton<AddBloodUseCase>(() => AddBloodUseCase(getIt()));
  getIt.registerLazySingleton<GetSugarReadsUseCase>(
    () => GetSugarReadsUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetBloodReadsUseCase>(
    () => GetBloodReadsUseCase(getIt()),
  );
  getIt.registerLazySingleton<UpdateSugarUseCase>(
    () => UpdateSugarUseCase(getIt()),
  );
  getIt.registerLazySingleton<UpdateBloodUseCase>(
    () => UpdateBloodUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetSugarMonthlyUseCase>(
    () => GetSugarMonthlyUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetSugarDailyUseCase>(
    () => GetSugarDailyUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetUserProfileUseCase>(
    () => GetUserProfileUseCase(getIt()),
  );
  getIt.registerLazySingleton<CreateMedicationUseCase>(
    () => CreateMedicationUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetMedicationsUseCase>(
    () => GetMedicationsUseCase(getIt()),
  );
  getIt.registerLazySingleton<AnalyzeVoiceUseCase>(
    () => AnalyzeVoiceUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetHomeDataUseCase>(
    () => GetHomeDataUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetHomeCaregiverDataUseCase>(
    () => GetHomeCaregiverDataUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetProfileCaregiverDataUseCase>(
    () => GetProfileCaregiverDataUseCase(getIt()),
  );
  getIt.registerLazySingleton<ConnectCaregiverWithElderUseCase>(
    () => ConnectCaregiverWithElderUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetCaregiverListUseCase>(
    () => GetCaregiverListUseCase(getIt()),
  );
  getIt.registerLazySingleton<TakeMedicationUseCase>(
    () => TakeMedicationUseCase(getIt()),
  );
  getIt.registerLazySingleton<SnoozeMedicationUseCase>(
    () => SnoozeMedicationUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetAllMedicationInCaregiverUseCase>(
    () => GetAllMedicationInCaregiverUseCase(getIt()),
  );
  getIt.registerLazySingleton<DoNotRememberUseCase>(
    () => DoNotRememberUseCase(getIt()),
  );
  getIt.registerLazySingleton<TabletModelUseCase>(
    () => TabletModelUseCase(getIt()),
  );
}
