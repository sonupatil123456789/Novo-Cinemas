import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:novocinema/core/theams/Utils.dart';


class CustomTextField extends StatefulWidget {
  double width;
  double? height;
  List<TextInputFormatter>? coustomInputFormatters;
  late TextEditingController? controller;
  Function getTextFieldValue;
  List<FormFieldValidator<String>>? validateTextField;
  dynamic startIcon;
  dynamic endIcon;
  String lable;
  bool? isReadOnly;
  TextInputType? keyboardType;

  CustomTextField({
    super.key,
    this.height,
    this.coustomInputFormatters,
    this.keyboardType = TextInputType.text,
    required this.width,
    this.controller,
    this.startIcon,
    this.endIcon,
    this.isReadOnly = false,
     this.validateTextField,
    required this.getTextFieldValue,
    required this.lable,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  int? maxLength;
  final borderRadius = const BorderRadius.all(Radius.circular(12));
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: widget.width,
      height: widget.height ?? context.getScreenHeight(8),
      // alignment: Alignment.centerLeft,
      // color: Colors.amberAccent,
      // decoration: BoxDecoration(
      //     color: primaryShade100, borderRadius: BorderRadius.circular(6)),
      child: TextFormField(
        onEditingComplete: () => FocusScope.of(context).nextFocus(),
        onFieldSubmitted: (String value) {},
        style:  context.textThemeDecoration.paragraphLarge.copyWith(fontSize: 14),
        autocorrect: true,
        inputFormatters: widget.coustomInputFormatters,
        autovalidateMode: AutovalidateMode.onUnfocus,
        readOnly:widget.isReadOnly!,
        // textAlign: TextAlign.left,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        // textAlignVertical: TextAlignVertical.center,
        maxLength: maxLength,
        // cursorColor: primaryShade500,
        validator: FormBuilderValidators.compose(widget.validateTextField ?? []),
        controller: widget.controller,
        cursorColor: context.colorPalette.accentColor,
          enableInteractiveSelection: true,

        onChanged: (value) {
          widget.getTextFieldValue(value);
        },
        decoration: InputDecoration(
          hintText: widget.lable ?? "",
          hintStyle: context.textThemeDecoration.paragraphLarge.copyWith(fontSize: 14, color: context.colorPalette.textColor.withOpacity(0.6)),
          filled: false,
          counterText: "",
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          enabledBorder: OutlineInputBorder(borderRadius: borderRadius,borderSide:BorderSide(width: 0.6, color: context.colorPalette.accentColor.withOpacity(0.6))),
          errorStyle: context.textThemeDecoration.paragraphMedium.copyWith(color: context.colorPalette.errorColor.withOpacity(0.6)),
          errorBorder:  OutlineInputBorder(borderRadius: borderRadius,borderSide:BorderSide(width: 0.6, color: context.colorPalette.errorColor)),
          border:  OutlineInputBorder(borderRadius: borderRadius,borderSide:BorderSide(width: 0.6, color: context.colorPalette.accentColor.withOpacity(0.6))),
          focusedBorder:  OutlineInputBorder(borderRadius: borderRadius,borderSide:BorderSide(width: 0.6, color: context.colorPalette.accentColor)),
        ),
      ),
    );
  }
}
