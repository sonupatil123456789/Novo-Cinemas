import 'package:flutter/material.dart';
import 'package:novocinema/core/theams/Utils.dart';

class IncDecCounter extends StatefulWidget {
  final bool  disabledAddButton;
  final bool  disabledRemoveButton;
  final Function(int) onClickPlus;
  final Function(int) onClickMinus;
  final double? fontSize ;
  final double? iconSize ;
  final double? width ;
  final double? height ;
  int? initialCount ;

  IncDecCounter(
      {Key? key,
        required this.disabledAddButton,
        required this.disabledRemoveButton,
        this.initialCount = 1,
        this.fontSize ,
        this.iconSize,
        this.width ,
        this.height,
        required this.onClickPlus,
        required this.onClickMinus,
      })
      : super(key: key);

  @override
  _IncDecCounterState createState() => _IncDecCounterState();
}

class _IncDecCounterState extends State<IncDecCounter> {


  final BorderRadius borderRadius = BorderRadius.circular(12);
  int _counter = 1;

  @override
  void initState() {
    super.initState();
    _counter = widget.initialCount!;
  }



  @override
  Widget build(BuildContext context) {

    return Container(
      alignment : Alignment.center ,
      height: context.getScreenWidth(widget.height ?? 9),
      width: context.getScreenWidth(widget.width ?? 25),
      decoration: BoxDecoration(
        color: context.colorPalette.accentColor,
          borderRadius: borderRadius
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: IgnorePointer(
              ignoring: widget.disabledRemoveButton,
              child: GestureDetector(
            
                onTap: () {
                  setState(() {
                    if (_counter > 1) {
                      _counter--;
                    }
                    widget.onClickMinus(widget.initialCount ?? 0);
                  });
                },
                child: Container(
                    height: context.getScreenWidth(widget.height ?? 9),
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      // color: widget.disabledRemoveButton ? context.colorPalette.accentColor.withOpacity(0.6) :context.colorPalette.accentColor,
                    ),
                    child: Icon(
                      Icons.remove,
                      color: context.colorPalette.blackColor,
                      size: context.getScreenWidth(widget.iconSize ?? 4),
                    )),
              ),
            ),
          ),
          Text(
            '${widget.initialCount}',
            style: context.textThemeDecoration.subTitleLarge.copyWith(
              color: context.colorPalette.darkGreyColor,
              fontSize: widget.fontSize
            )
          ),
          Expanded(
            child: IgnorePointer(
              ignoring: widget.disabledAddButton,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _counter++;
                    widget.onClickPlus(widget.initialCount ?? 0);
                  });
                },
                child: Container(
                    height: context.getScreenWidth(widget.height ?? 9),
                    decoration: BoxDecoration(
                      color: context.colorPalette.accentColor,
                      borderRadius: borderRadius,
                    ),
                    child: Icon(
                      Icons.add,
                      size: context.getScreenWidth(widget.iconSize ?? 4),
                      color: context.colorPalette.blackColor,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

