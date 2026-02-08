import 'package:flutter/material.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/styling.dart';
import 'package:raai/feature/models/presentation/manager/sugar_daily/sugar_daily_cubit.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CustomCircleRangeDaily extends StatelessWidget {
  const CustomCircleRangeDaily({super.key, required this.state});

  final SugarDailySuccess state;

  @override
  Widget build(BuildContext context) {
    final p = state.data.probability.clamp(0.0, 1.0);

    return SizedBox(
      width: 150,
      height: 150,
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 1,
            showTicks: false,
            showLabels: false,

            startAngle: 150,
            endAngle: 35,
            ranges: [
              GaugeRange(
                startValue: 0.0,
                endValue: 0.3,
                color: AppColor.greenNormalActive,
                startWidth: 0.18,
                endWidth: 0.18,
                sizeUnit: GaugeSizeUnit.factor,
              ),
              GaugeRange(
                startValue: 0.3,
                endValue: 0.6,
                color: AppColor.yellowNormalActive,
                startWidth: 0.18,
                endWidth: 0.18,
                sizeUnit: GaugeSizeUnit.factor,
              ),
              GaugeRange(
                startValue: 0.6,
                endValue: 0.8,
                color: AppColor.orangeNormalActive,
                startWidth: 0.18,
                endWidth: 0.18,
                sizeUnit: GaugeSizeUnit.factor,
              ),
              GaugeRange(
                startValue: 0.8,
                endValue: 1.0,
                color: AppColor.redNormalActive,
                startWidth: 0.18,
                endWidth: 0.18,
                sizeUnit: GaugeSizeUnit.factor,
              ),
              GaugeRange(
                startValue: p,
                endValue: 1.0,
                color: AppColor.white,
                startWidth: 0.18,
                endWidth: 0.18,
                sizeUnit: GaugeSizeUnit.factor,
              ),
            ],

            axisLineStyle: const AxisLineStyle(
              thickness: 0.18,
              thicknessUnit: GaugeSizeUnit.factor,
              color: AppColor.white,
              cornerStyle: CornerStyle.bothCurve,
            ),

            pointers: [
              RangePointer(
                value: state.data.probability,
                width: .18,
                sizeUnit: GaugeSizeUnit.factor,
                cornerStyle: CornerStyle.bothCurve,
                color: Colors.transparent,
              ),
            ],

            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                widget: Text(
                  '${state.data.prac}%',
                  style: AppTextStyles.s24.w700.textNormal,
                ),
                angle: 90,
                positionFactor: 0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
