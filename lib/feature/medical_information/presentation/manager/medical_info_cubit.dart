import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:raai/feature/medical_information/data/model/survey_question.dart';

part 'medical_info_state.dart';

class MedicalInfoCubit extends Cubit<MedicalInfoState> {
  MedicalInfoCubit() : super(MedicalInfoInitial());

  int count = 0;

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

  void increment() {
    if (count < surveyQuestions.length - 1) {
      count++;
      emit(MedicalInfoInitial());
    }
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
      options: ['وزنك كام كيلو',],
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
}
