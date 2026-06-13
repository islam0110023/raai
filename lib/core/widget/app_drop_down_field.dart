import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:raai/core/utils/app_color.dart';
import 'package:raai/core/utils/styling.dart';

class AppDropDownField<T> extends StatefulWidget {
  const AppDropDownField({
    super.key,
    required this.label,
    required this.options,
    required this.itemTitle,
    this.selectedValues,
    this.onChanged,
    required this.hint,
    this.multiSelect = true,
  });

  final String label;
  final List<T> options;
  final List<T>? selectedValues;
  final void Function(List<T>)? onChanged;
  final String Function(T item) itemTitle;
  final String hint;
  final bool multiSelect;

  @override
  State<AppDropDownField<T>> createState() => _AppDropDownFieldState<T>();
}

class _AppDropDownFieldState<T> extends State<AppDropDownField<T>> {
  bool isShow = false;
  late List<T> selectedItems;

  @override
  void initState() {
    super.initState();
    selectedItems = widget.selectedValues ?? [];
  }

  void toggleShow() {
    setState(() {
      isShow = !isShow;
    });
  }

  void toggleSelection(T value) {
    setState(() {
      if (widget.multiSelect) {
        if (selectedItems.contains(value)) {
          selectedItems.remove(value);
        } else {
          selectedItems.add(value);
        }
      } else {
        selectedItems = [value];
        isShow = false;
      }
    });

    widget.onChanged?.call(selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    final selectedText = selectedItems.isEmpty
        ? widget.hint
        : selectedItems.map(widget.itemTitle).join(', ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: AppTextStyles.s16.w400.textNormal),
        const RSizedBox(height: 9),
        GestureDetector(
          onTap: toggleShow,
          child: Container(
            padding: EdgeInsets.all(2.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: AppColor.disableNormal,
            ),
            child: Container(
              height: 51.h,
              padding: EdgeInsets.symmetric(horizontal: 13.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColor.disableLightHover,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      selectedText,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.s16.w500.textNormal,
                    ),
                  ),
                  Icon(
                    isShow
                        ? CupertinoIcons.chevron_up
                        : CupertinoIcons.chevron_down,
                    size: 24.r,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (isShow)
          Container(
            padding: EdgeInsets.all(2.r),
            margin: EdgeInsets.only(top: 8.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: AppColor.disableNormal,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColor.disableLightHover,
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.options.length,
                itemBuilder: (context, index) {
                  final item = widget.options[index];

                  return CustomItemDropDownProfile(
                    name: widget.itemTitle(item),
                    isSelected: selectedItems.contains(item),
                    onTap: () => toggleSelection(item),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}

class CustomItemDropDownProfile extends StatelessWidget {
  const CustomItemDropDownProfile({
    super.key,
    required this.name,
    required this.onTap,
    this.isSelected = false,
  });
  final String name;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      dense: true,
      leading: Icon(
        isSelected ? Icons.check_circle_outline : Icons.radio_button_unchecked,
        color: isSelected ? AppColor.primaryNormal : AppColor.black,
      ),
      title: Text(name, style: AppTextStyles.s16.w500.textNormal),
    );
  }
}
