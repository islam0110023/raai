import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:raai/core/failure/api_error_mapper.dart';
import 'package:raai/feature/medical_information/data/model/survey_question.dart';
import 'package:raai/feature/medical_information/domain/use_case/set_medical_use_case.dart';

part 'medical_info_state.dart';

class MedicalInfoCubit extends Cubit<MedicalInfoState> {
  MedicalInfoCubit(this.setMedicalUseCase) : super(MedicalInfoInitial()) {
    init();
  }
  final SetMedicalUseCase setMedicalUseCase;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  late TextEditingController weightController;
  late TextEditingController heightController;

  void init() {
    weightController = TextEditingController();
    heightController = TextEditingController();
  }

  int count = 0;
  void setMedical([int? elderId]) async {
    emit(MedicalInfoLoading());
    final result = await setMedicalUseCase(
      data: buildRequestJson(),
      elderId: elderId,
    );
    result.fold(
      (failure) {
        final message = ApiErrorMapper.getArabicMessage(failure.appCode);

        emit(MedicalInfoFailure(message, failure.appCode));
      },
      (success) {
        emit(MedicalInfoSuccess(appCode: success));
      },
    );
  }

  List<int?> selectedIndexes = List.filled(9, null);

  final Map<String, dynamic> answers = {};
  void changeSelectedIndex(int index) {
    selectedIndexes[count] = index;
    final q = surveyQuestions[count];
    if (q.type == QuestionType.boolean || q.type == QuestionType.singleChoice) {
      answers[q.key] = q.options[index];
    }

    emit(MedicalInfoInitial());
  }

  void updateWeight() {
    answers['weight'] = weightController.text;
    emit(MedicalInfoInitial());
  }

  void updateHeight() {
    answers['height'] = heightController.text;
    emit(MedicalInfoInitial());
  }

  void increment() {
    if (count < surveyQuestions.length - 1) {
      count++;
      emit(MedicalInfoInitial());
    }
  }

  void changeAutoValidateMode() {
    autoValidateMode = AutovalidateMode.always;
    emit(MedicalInfoInitial());
  }

  void decrement() {
    if (count > 0) {
      count--;
      emit(MedicalInfoInitial());
    }
  }

  final List<SurveyQuestion> surveyQuestions = [
    const SurveyQuestion(
      id: 1,
      key: 'hypertension',
      question: 'هل تم تشخيصك بارتفاع ضغط الدم؟',
      type: QuestionType.boolean,
      options: ['نعم', 'لا'],
    ),
    const SurveyQuestion(
      id: 2,
      key: 'heart_disease',
      question: 'هل عندك أي مشاكل أو أمراض في القلب؟',
      type: QuestionType.boolean,
      options: ['نعم', 'لا'],
    ),
    const SurveyQuestion(
      id: 3,
      key: 'diabetes',
      question: 'هل عندك مرض السكر؟',
      type: QuestionType.singleChoice,
      options: ['نعم', 'لا', 'مقاومة إنسولين'],
    ),
    const SurveyQuestion(
      id: 4,
      key: 'weight',
      question: 'وزنك كام كيلو؟',
      type: QuestionType.number,
      options: ['وزنك كام كيلو'],
    ),
    const SurveyQuestion(
      id: 5,
      key: 'height',
      question: 'طولك كام بالسنتيمتر؟',
      type: QuestionType.number,
      options: ['طولك كام بالسنتيمتر'],
    ),
    const SurveyQuestion(
      id: 6,
      key: 'smoking_status',
      question: 'هل بتدخّن؟',
      type: QuestionType.singleChoice,
      options: [
        'مدخّنتش قبل كدا',
        'كان بيدخّن زمان وبطّل',
        'بيدخّن دلوقتي',
        'مبطل قريب',
        'دخّن قبل كدا',
      ],
    ),
    const SurveyQuestion(
      id: 7,
      key: 'activity_level',
      question: 'مستوى نشاطك اليومي عامل إزاي؟',
      type: QuestionType.singleChoice,
      options: ['قليل جدًا', 'متوسط', 'عالي', 'بمشي كتير يوميًا'],
    ),
    const SurveyQuestion(
      id: 8,
      key: 'family_history',
      question: 'هل في حد في العيلة عنده سكر أو ضغط؟',
      type: QuestionType.singleChoice,
      options: ['نعم', 'لا', 'مش متأكد'],
    ),
    const SurveyQuestion(
      id: 9,
      key: 'sleep_quality',
      question: 'بتنام كويس ولا نومك متقطع؟',
      type: QuestionType.singleChoice,
      options: ['بنام كويس', 'النوم متقطع', 'عندي صعوبة في النوم'],
    ),
  ];
  Map<String, dynamic> buildRequestJson() {
    return {
      'hypertension': _mapYesNoToBool(answers['hypertension']),
      'heartDisease': _mapYesNoToBool(answers['heart_disease']),
      'diabetes': _mapDiabetesStatus(answers['diabetes']),
      'weightKg': _toInt(answers['weight']),
      'heightCm': _toInt(answers['height']),
      'smokingStatus': _mapSmokingStatus(answers['smoking_status']),
      'activityLevel': _mapActivityLevel(answers['activity_level']),
      'familyHistory': _mapFamilyHistory(answers['family_history']),
      'sleepQuality': _mapSleepQuality(answers['sleep_quality']),
    };
  }

  bool _mapYesNoToBool(dynamic value) {
    return value?.toString().trim() == 'نعم';
  }

  String _mapDiabetesStatus(dynamic value) {
    switch (value) {
      case 'نعم':
        return 'YES';
      case 'لا':
        return 'NO';
      case 'مقاومة إنسولين':
        return 'INSULIN_RESISTANCE';
      default:
        return 'NO';
    }
  }

  String _mapSmokingStatus(dynamic value) {
    switch (value) {
      case 'مدخّنتش قبل كدا':
        return 'NEVER';
      case 'كان بيدخّن زمان وبطّل':
        return 'FORMER';
      case 'بيدخّن دلوقتي':
        return 'CURRENT';
      case 'مبطل قريب':
        return 'RECENTLY_QUIT';
      case 'دخّن قبل كدا':
        return 'SMOKED_BEFORE';
      default:
        return 'NEVER';
    }
  }

  String _mapActivityLevel(dynamic value) {
    switch (value) {
      case 'قليل جدًا':
        return 'VERY_LOW';
      case 'متوسط':
        return 'MEDIUM';
      case 'عالي':
        return 'HIGH';
      case 'بمشي كتير يوميًا':
        return 'VERY_ACTIVE';
      default:
        return 'MEDIUM';
    }
  }

  String _mapSleepQuality(dynamic value) {
    switch (value) {
      case 'بنام كويس':
        return 'GOOD';
      case 'النوم متقطع':
        return 'INTERRUPTED';
      case 'عندي صعوبة في النوم':
        return 'DIFFICULT';
      default:
        return 'GOOD';
    }
  }

  String _mapFamilyHistory(dynamic value) {
    switch (value) {
      case 'نعم':
        return 'YES';
      case 'لا':
        return 'NO';
      case 'مش متأكد':
        return 'NOT_SURE';
      default:
        return 'NOT_SURE';
    }
  }

  int _toInt(dynamic value) {
    if (value == null) return 0;
    return int.tryParse(value.toString()) ?? 0;
  }

  @override
  Future<void> close() {
    // TODO: implement close
    weightController.dispose();
    heightController.dispose();
    return super.close();
  }
}
