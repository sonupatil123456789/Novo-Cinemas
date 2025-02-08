import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:novocinema/core/theams/Utils.dart';

class AuthTextField extends StatefulWidget {
  double width;
  // double? height;
  List<TextInputFormatter>? coustomInputFormatters;
  late TextEditingController? controller;
  Function getTextFieldValue;
  List<FormFieldValidator<String>> validateTextField;
  String lable;
  String hintText;
  TextInputType? keyboardType;

  AuthTextField({
    super.key,
    // this.height,
    this.coustomInputFormatters,
    this.keyboardType = TextInputType.text,
    required this.width,
    required this.hintText,
    this.controller,
    required this.validateTextField,
    required this.getTextFieldValue,
    required this.lable,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  int? maxLength;
  final borderRadius = const BorderRadius.all(Radius.circular(12));

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      onFieldSubmitted: (String value) {},
      style:  context.textThemeDecoration.paragraphLarge.copyWith(fontSize: 15),
      autocorrect: true,
      inputFormatters: widget.coustomInputFormatters,
      autovalidateMode: AutovalidateMode.onUnfocus,
      // textAlign: TextAlign.left,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      // textAlignVertical: TextAlignVertical.center,
      maxLength: maxLength,
      // cursorColor: primaryShade500,
      // validator: widget.validateTextField,
      validator: FormBuilderValidators.compose(widget.validateTextField),
      // validator: FormBuilderValidators.compose([
      //   FormBuilderValidators.required()
      // ]),
      controller: widget.controller,
      cursorColor: context.colorPalette.accentColor,
      enableInteractiveSelection: true,
      onChanged: (value) {
        widget.getTextFieldValue(value);
      },
      decoration: InputDecoration(
        hintText: widget.lable ?? "",
        hintStyle: context.textThemeDecoration.paragraphLarge.copyWith(fontSize: 15, color: context.colorPalette.textColor.withOpacity(0.6)),
        filled: false,
        counterText: "",
        contentPadding:  EdgeInsets.symmetric(horizontal: 20.0,vertical: context.getScreenHeight(2)),
        constraints: BoxConstraints(
          minWidth: 100,
          maxWidth: widget.width
        ),
        enabledBorder: OutlineInputBorder(borderRadius: borderRadius,borderSide:BorderSide(width: 0.6, color: context.colorPalette.accentColor.withOpacity(0.6))),
        errorStyle: context.textThemeDecoration.paragraphMedium.copyWith(color: context.colorPalette.errorColor.withOpacity(0.6)),
        errorBorder:  OutlineInputBorder(borderRadius: borderRadius,borderSide:BorderSide(width: 0.6, color: context.colorPalette.errorColor)),
        border:  OutlineInputBorder(borderRadius: borderRadius,borderSide:BorderSide(width: 0.6, color: context.colorPalette.accentColor.withOpacity(0.6))),
        focusedBorder:  OutlineInputBorder(borderRadius: borderRadius,borderSide:BorderSide(width: 0.6, color: context.colorPalette.accentColor)),
      ),
    );
  }
}
