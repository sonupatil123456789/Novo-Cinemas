import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novocinema/core/theams/Utils.dart';
import 'package:novocinema/core/utils/CurrencyFormater.dart';

import '../bloc/GiftCardBloc.dart';

class AddBalanceCounter extends StatefulWidget {
  final bool disabledAddButton;
  final bool disabledRemoveButton;
  final Function(int) onClickPlus;
  final Function(int) onClickMinus;
  final double? fontSize;

  final double? iconSize;

  int? initialCount;

  AddBalanceCounter({
    Key? key,
    required this.disabledAddButton,
    required this.disabledRemoveButton,
    this.initialCount = 1,
    this.fontSize,
    this.iconSize,
    required this.onClickPlus,
    required this.onClickMinus,
  }) : super(key: key);

  @override
  _AddBalanceCounterState createState() => _AddBalanceCounterState();
}

class _AddBalanceCounterState extends State<AddBalanceCounter> {
  final BorderRadius borderRadius = BorderRadius.circular(12);
  int _counter = 1;

  @override
  void initState() {
    super.initState();
    _counter = widget.initialCount!;
    final Map<String, dynamic> data = {
      'price': (widget.initialCount ?? 0) * 100
    };
    context.read<GiftCardBloc>().add(GetSendGiftCardRequestEvent(data));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: context.getScreenWidth(100),
      decoration: BoxDecoration(
          // color: context.colorPalette.accentColor,
          borderRadius: borderRadius),
      child: Column(
        children: [
          SizedBox(
            height: context.getScreenWidth(widget.iconSize ?? 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IgnorePointer(
                  ignoring: _counter == 0 ? true : false,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_counter > 1) {
                          _counter -= 50;
                        }
                        widget.onClickMinus(_counter);
                      });
                    },
                    child: Container(
                        width: context.getScreenWidth(widget.iconSize ?? 6),
                        height: context.getScreenWidth(widget.iconSize ?? 6),
                        decoration: BoxDecoration(
                          color: _counter == 1
                              ? context.colorPalette.accentColor
                                  .withOpacity(0.1)
                              : context.colorPalette.accentColor
                                  .withOpacity(0.3),
                          border: Border.all(
                              color: _counter == 1
                                  ? context.colorPalette.accentColor
                                      .withOpacity(0.1)
                                  : context.colorPalette.accentColor
                                      .withOpacity(0.3)),
                          // color: context.colorPalette.accentColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.remove,
                          color: context.colorPalette.reverseBackGroundColor
                              .withOpacity(_counter == 1 ? 0.6 : 1),
                          size: context.getScreenWidth(3.5),
                        )),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color:
                            context.colorPalette.accentColor.withOpacity(0.1),
                        // color: context.colorPalette.accentColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: context.colorPalette.accentColor
                                .withOpacity(0.4))),
                    child: Text(
                      '${currencyCode()} $_counter',
                      style: context.textThemeDecoration.subTitleMedium
                          .copyWith(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                IgnorePointer(
                  ignoring: widget.disabledAddButton,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _counter += 50;
                        widget.onClickPlus(_counter);
                      });
                    },
                    child: Container(
                        width: context.getScreenWidth(widget.iconSize ?? 6),
                        height: context.getScreenWidth(widget.iconSize ?? 6),
                        decoration: BoxDecoration(
                          color:
                              context.colorPalette.accentColor.withOpacity(0.3),
                          border: Border.all(
                              color: context.colorPalette.accentColor
                                  .withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.add,
                          size: context.getScreenWidth(3.5),
                          color: context.colorPalette.reverseBackGroundColor,
                        )),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [currencyAddOn(150), currencyAddOn(250)],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [currencyAddOn(550), currencyAddOn(1000)],
          )
        ],
      ),
    );
  }

  Widget currencyAddOn(int amt) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _counter = amt;
          widget.onClickPlus(_counter);
        });
      },
      child: Container(
        alignment: Alignment.center,
        width: context.getScreenWidth(37),
        height: context.getScreenWidth(12),
        decoration: BoxDecoration(
            color: context.colorPalette.accentColor.withOpacity(0.1),
            // color: context.colorPalette.accentColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: context.colorPalette.accentColor.withOpacity(0.4))),
        child: Text(
          '${currencyCode()} ${amt.toString()}',
          style:
              context.textThemeDecoration.subTitleMedium.copyWith(fontSize: 16),
        ),
      ),
    );
  }
}
