//
// import 'package:cabrenting/constants/color_pallet.dart';
// import 'package:flutter/material.dart';
//
//
// class CoustomSwitch extends StatefulWidget {
//   Function switchValue;
//   Color? switchActiveColor;
//   Color? switchDeactiveColor;
//   Color? activeTrackColor;
//   Color? dActiveTrackColor;
//
//   CoustomSwitch({super.key,
//    required this.switchValue,
//     this.switchActiveColor,
//     this.switchDeactiveColor,
//     this.activeTrackColor,
//     this.dActiveTrackColor
//    });
//
//   @override
//   State<CoustomSwitch> createState() => _CoustomSwitchState();
// }
//
// class _CoustomSwitchState extends State<CoustomSwitch> {
//   bool _isToggled = false;
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//
//       width: MediaQuery.of(context).size.width*0.12,
//       height:  MediaQuery.of(context).size.width*0.08,
//
//       child: Switch(
//           value: _isToggled,
//           inactiveThumbColor: widget.switchDeactiveColor?? ColorPallet.lightGrayTextColor,
//           inactiveTrackColor :widget.dActiveTrackColor ?? ColorPallet.pinkContainerSplashColor,
//           activeTrackColor:widget.activeTrackColor ?? ColorPallet.pinkContainerSplashColor,
//           activeColor: widget.switchActiveColor ?? ColorPallet.pinkAccentColor,// fc4102
//           onChanged: (value) {
//             setState(() {
//               _isToggled = value;
//               widget.switchValue(value);
//             });
//           }),
//     );
//   }
// }
