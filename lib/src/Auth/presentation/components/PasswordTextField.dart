import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:novocinema/core/theams/Utils.dart';

class PasswordTextField extends StatefulWidget {
  double width;
  double? height;
  List<TextInputFormatter>? coustomInputFormatters;
  late TextEditingController? controller;
  Function getTextFieldValue;
  String lable;
  String hintText;
  TextInputType? keyboardType;

  PasswordTextField({
    super.key,
    this.height,
    this.coustomInputFormatters,
    this.keyboardType = TextInputType.text,
    required this.width,
    required this.hintText,
    this.controller,
    required this.getTextFieldValue,
    required this.lable,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  int? maxLength;
  bool hidePassword = true ;
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
      obscureText: hidePassword,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      maxLength: maxLength,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.password(minSpecialCharCount: 0 , minLength: 6,maxLength: 18,minUppercaseCount: 0)
      ]),
      controller: widget.controller,
      cursorColor: context.colorPalette.accentColor,
      enableInteractiveSelection: true,
      onChanged: (value) {
        widget.getTextFieldValue(value);
      },
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: (){
            setState(() {
              hidePassword = !hidePassword;
            });
          },
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
                child: Icon(hidePassword ? Icons.visibility : Icons.visibility_off, size: 18, color: context.colorPalette.accentColor,))),
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
