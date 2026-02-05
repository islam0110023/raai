import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/app_icons.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/core/widget/app_text_field.dart';
import 'package:raai/feature/medical_information/data/model/survey_question.dart';
import 'package:raai/feature/medical_information/presentation/manager/medical_info_cubit.dart';
import 'package:raai/feature/medical_information/presentation/view/widget/option_tile.dart';

class MedicalInformationScreenBody extends StatelessWidget {
  const MedicalInformationScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MedicalInfoCubit>();
    final cubit = context.read<MedicalInfoCubit>();

    return SafeArea(
      minimum: REdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Form(
          key: cubit.formKey,
          autovalidateMode: state.autoValidateMode,
          child: Column(
            children: [
              Text(
                'السؤال ${state.count + 1} من 9',
                style: AppTextStyles.s16.w500.black,
              ),
              const RSizedBox(height: 16),
              LinearProgressIndicator(
                value: (state.count + 1) / 9,
                borderRadius: BorderRadius.circular(64),
                minHeight: 16.h,
                color: AppColor.primaryNormal,
                backgroundColor: AppColor.secondaryLight,
              ),
              const RSizedBox(height: 32),
              Container(
                width: double.infinity,
                height: 184.h,
                padding: REdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColor.shadowColor,
                      blurRadius: 12,
                      offset: Offset(0, 0),
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cubit.surveyQuestions[state.count].question,
                      style: AppTextStyles.s20.w600.black,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: CircleAvatar(
                        radius: 20.r,
                        backgroundColor: AppColor.primaryNormal,
                        child: Icon(
                          Icons.volume_up_outlined,
                          color: AppColor.white,
                          size: 28.r,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const RSizedBox(height: 32),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  cubit.surveyQuestions[state.count].type ==
                          QuestionType.singleChoice
                      ? 'اختر الاجابه الاقرب من تقديرك'
                      : 'املا البيانات التاليه',
                  style: AppTextStyles.s16.w500.black,
                ),
              ),
              const RSizedBox(height: 16),
              Visibility(
                visible:
                    cubit.surveyQuestions[state.count].type ==
                    QuestionType.singleChoice,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return OptionTile(
                      text: cubit.surveyQuestions[state.count].options[index],
                      isSelected: state.selectedIndexes[state.count] == index,
                      onTap: () {
                        cubit.changeSelectedIndex(index);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const RSizedBox(height: 8);
                  },
                  itemCount: cubit.surveyQuestions[state.count].options.length,
                ),
              ),
              Visibility(
                visible:
                    cubit.surveyQuestions[state.count].type ==
                    QuestionType.boolean,
                child: Column(
                  spacing: 24.h,
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return OptionTile(
                          text:
                              cubit.surveyQuestions[state.count].options[index],
                          isSelected:
                              state.selectedIndexes[state.count] == index,
                          onTap: () {
                            cubit.changeSelectedIndex(index);
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const RSizedBox(height: 8);
                      },
                      itemCount:
                          cubit.surveyQuestions[state.count].options.length,
                    ),

                    Visibility(
                      visible: state.selectedIndexes[state.count] == 0,
                      child: const AppTextField(
                        hint: 'فسر اجابتك هنا',
                        maxLines: 4,
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: cubit.surveyQuestions[state.count].id == 4,
                child: Row(
                  spacing: 10.5.w,
                  children: [
                    Container(
                      padding: REdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColor.primaryNormal,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: SvgPicture.asset(AppIcons.plusIcon),
                    ),
                    Expanded(
                      child: AppTextField(
                        key: UniqueKey(),
                        hint: cubit.surveyQuestions[state.count].options[0],
                        controller: cubit.weightController,
                        padding: REdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: 16,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يجب ادخال وزنك';
                          }
                          return null;
                        },
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                      ),
                    ),
                    Container(
                      padding: REdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColor.primaryNormal,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: SvgPicture.asset(AppIcons.minusIcon),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: cubit.surveyQuestions[state.count].id == 5,
                child: Row(
                  spacing: 10.5.w,
                  children: [
                    Container(
                      padding: REdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColor.primaryNormal,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: SvgPicture.asset(AppIcons.plusIcon),
                    ),
                    Expanded(
                      child: AppTextField(
                        key: UniqueKey(),
                        hint: cubit.surveyQuestions[state.count].options[0],
                        controller: cubit.heightController,
                        padding: REdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: 16,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يجب ادخال طولك';
                          }
                          return null;
                        },
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                      ),
                    ),
                    Container(
                      padding: REdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColor.primaryNormal,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: SvgPicture.asset(AppIcons.minusIcon),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
