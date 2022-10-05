import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maby_common/context_extension.dart';
import 'package:maby_salon/data/models/input_state_model.dart';
import 'package:maby_salon/gen/assets.gen.dart';
import 'package:maby_salon/utils/salon_state_extension.dart';

import '../../salon_theme.dart';

class CustomTextField extends FormField<String> {
  CustomTextField({
    Key? key,
    String? initialValue,
    String? hint,
    String? title,
    Widget? action,
    Color? hintColor,
    Color? styleColor,
    int? maxLines = 1,
    int? maxLength,
    bool? mEnable,
    FormFieldSetter<String>? onSaved,
    bool isPassword = false,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    TextCapitalization? textCapitalization,
    TextEditingController? textEditingController,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    FormFieldValidator<String>? validator,
    List<TextInputFormatter>? textInputFormatter,
    FloatingLabelBehavior floatingLabelBehavior = FloatingLabelBehavior.never,
    Color? backgroundColor,
    String? description,
    Widget? suffixIcon,
    Widget? prefixIcon,
    Widget? iconShowPassword,
    Widget? iconHidePassword,
    StreamController<InputStateModel>? inputStateController,
    bool enableTextError = true,
    EdgeInsets? contentPadding,
    bool? isRequired,
    TextStyle? titleStyle,
    VoidCallback? onTap,
    Key? mKey,
  }) : super(
          key: key,
          initialValue: initialValue,
          onSaved: onSaved,
          validator: validator,
          builder: (stateFormField) {
            final state = stateFormField as CustomTextFieldState;
            final customColor =
                Theme.of(state.context).extension<SalonTheme>()!;
            final border = Border.all(
              color: state.hasError
                  ? customColor.danger[1]!
                  : state.isFocus
                      ? customColor.focusInputColor
                      : Colors.transparent,
              width: 1,
            );
            final List<BoxShadow>? boxShadow = !state.isFocus
                ? [
                    BoxShadow(
                      color: customColor.inputInnerShadow.withOpacity(.1),
                    ),
                    BoxShadow(
                        color: customColor.grayPalette[7]!,
                        offset: const Offset(0, 2),
                        blurRadius: 2,
                        spreadRadius: -1,
                        blurStyle: BlurStyle.inner)
                  ]
                : null;

            return GestureDetector(
              onTap: () {
                onTap?.call();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null)
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              title,
                              style: titleStyle ??
                                  state.context.textTheme.subtitle1?.copyWith(
                                      color: customColor.grayPalette[2]),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            if (isRequired ?? false)
                              Text(
                                "*",
                                style:
                                    state.context.textTheme.subtitle1?.copyWith(
                                  color: state.context.salonTheme.danger[1],
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                  Container(
                    height: maxLines != 1 ? null : 46,
                    decoration: BoxDecoration(
                      color: mEnable == false
                          ? const Color(0xffE0E0E0)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: border,
                      boxShadow: mEnable == false ? null : boxShadow,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Row(
                      children: [
                        if (prefixIcon != null)
                          prefixIcon,
                        Expanded(
                          child: TextFormField(
                            enabled: mEnable,
                            maxLines: maxLines,
                            maxLength: maxLength,
                            focusNode: state.focusNode,
                            cursorColor: styleColor ?? Colors.transparent,
                            obscureText: isPassword,
                            controller: textEditingController,
                            obscuringCharacter: '*',
                            textAlign: TextAlign.justify,
                            onChanged: (value) {
                              state.didChange(value);
                              onChanged?.call(value);
                            },
                            validator: validator,
                            style: state.context.textTheme.bodyText2,
                            decoration: const InputDecoration()
                                .applyDefaults(Theme.of(state.context)
                                    .inputDecorationTheme)
                                .copyWith(
                                  hintText: hint,
                                  hintStyle: state.context.textTheme.bodyText2
                                      ?.copyWith(
                                    color: customColor.inputHintColor,
                                  ),
                                  errorStyle: const TextStyle(
                                      height: 0.01, color: Colors.transparent),
                                  floatingLabelBehavior: floatingLabelBehavior,
                                  counterStyle:
                                      state.context.textTheme.caption?.copyWith(
                                    color: Colors.transparent,
                                    height: double.minPositive,
                                  ),
                                  counterText: "",
                                  contentPadding: contentPadding ??
                                      const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 0)
                                          .copyWith(top: 18),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent, width: 1),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent, width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent, width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent, width: 1),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent, width: 1),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.transparent, width: 1),
                                  ),
                                ),
                          ),
                        ),
                        if (suffixIcon != null) ...[
                          const SizedBox(
                            width: 4,
                          ),
                          suffixIcon,
                        ] else if (isPassword && iconHidePassword != null)
                          InkResponse(
                            onTap: () {
                              isPassword = false;
                              state.setState(() {});
                            },
                            child: iconHidePassword,
                          )
                        else if (!isPassword && iconShowPassword != null)
                          InkResponse(
                            onTap: () {
                              isPassword = true;
                              state.setState(() {});
                            },
                            child: iconShowPassword,
                          )
                      ],
                    ),
                  ),
                  if (maxLength != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "${(state.value?.length ?? 0)}/$maxLength",
                            style: state.context.textTheme.caption?.copyWith(
                              color: state.context.salonTheme.grayPalette[3],
                            ),
                          )
                        ],
                      ),
                    ),
                  if (enableTextError)
                    if (state.hasError)
                      SizedBox(
                        height: 24,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                Assets.icons.icError.svg(),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  state.errorText ?? '',
                                  style: state.context.textTheme.caption,
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    else
                      const SizedBox(
                        height: 24,
                      )
                ],
              ),
            );
          },
        );

  @override
  FormFieldState<String> createState() => CustomTextFieldState();
}

class CustomTextFieldState extends FormFieldState<String> {
  FocusNode focusNode = FocusNode();

  bool isFocus = false;

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        isFocus = false;
        setState(() {});
      } else {
        isFocus = true;
        setState(() {});
      }
    });
  }
}
