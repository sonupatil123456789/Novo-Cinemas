



import 'package:flutter/material.dart';
import 'package:novocinema/components/AppBarSection.dart';
import 'package:novocinema/core/theams/Utils.dart';

class CustomSlider extends StatefulWidget {
  Function onRangeEnd;

CustomSlider({super.key, required this.onRangeEnd});

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _value = 20;

  @override
  Widget build(BuildContext context) {
    return Slider(
      min: 0.0,
      activeColor: context.colorPalette.accentColor,
      label: 'hello',
      max: 100.0,
      onChangeEnd: (value) => widget.onRangeEnd,
      value: _value,
      onChanged: (value) {
        setState(() {
          _value = value;
        });
      },
    );
  }
}
