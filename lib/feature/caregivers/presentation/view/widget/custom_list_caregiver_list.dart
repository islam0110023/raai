import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/widget/error_view.dart';
import 'package:raai/core/widget/no_data_view.dart';
import 'package:raai/core/widget/shimmer_effect.dart';
import 'package:raai/feature/caregivers/presentation/manager/caregiver_list/caregiver_list_cubit.dart';
import 'package:raai/feature/caregivers/presentation/view/widget/custom_card_caregivers_list.dart';
import 'package:raai/feature/caregivers/presentation/view/widget/custom_dialog_remove_caregiver.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomListCaregiverList extends StatelessWidget {
  const CustomListCaregiverList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CaregiverListCubit, CaregiverListState>(
      builder: (context, state) {
        if (state is CaregiverListLoading) {
          return SliverPadding(
            padding: REdgeInsets.symmetric(horizontal: 16.r),
            sliver: SliverList.separated(
              itemBuilder: (context, index) {
                return ShimmerEffect(width: double.infinity, height: 65.h);
              },
              separatorBuilder: (context, index) {
                return const RSizedBox(height: 16);
              },
              itemCount: 10,
            ),
          );
        }
        if (state is CaregiverListNoData) {
          return SliverPadding(
            padding: REdgeInsets.symmetric(horizontal: 16.r),
            sliver: const SliverToBoxAdapter(
              child: NoDataView(
                message: 'لا يوجد مرافقين بعد',
                subMessage: 'قم بدعوة مرافق لمساعدتك في متابعة صحتك',
              ),
            ),
          );
        }
        if (state is CaregiverListSuccess) {
          return SliverPadding(
            padding: REdgeInsets.symmetric(horizontal: 16.r),
            sliver: SliverList.separated(
              itemBuilder: (context, index) {
                final data = state.data[index];
                return CustomCardCaregiversList(
                  title: data.name,
                  subtitle: data.isPrimary ? 'مرافق رئيسي' : 'مرافق',
                  status: 'متصل',
                  onCall: () async {
                    try {
                      await launchUrl(Uri.parse('tel:${data.phone}'));
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  },
                  onDelete: () {
                    final cubit = context.read<CaregiverListCubit>();
                    showDialog(
                      context: context,
                      useSafeArea: false,
                      animationStyle: const AnimationStyle(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      ),
                      barrierColor: AppColor.white.withAlpha(50),
                      builder: (contextDialog) {
                        return BlocProvider.value(
                          value: cubit,
                          child: CustomDialogRemoveCaregiver(data: data),
                        );
                      },
                    );
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const RSizedBox(height: 16);
              },
              itemCount: state.data.length,
            ),
          );
        }
        if (state is CaregiverListFailure) {
          return SliverPadding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: ErrorView(
                onPressed: () {
                  context.read<CaregiverListCubit>().getCaregiverList();
                },

                message: state.message,
              ),
            ),
          );
        }
        return const SliverToBoxAdapter();
      },
    );
  }
}
