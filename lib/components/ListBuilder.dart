

import 'package:flutter/material.dart';

class ListBuilder<T> extends StatelessWidget {
  final double width;
  final double height;
  final List<T> data;
  final Widget Function(BuildContext context, int index, T value) itemBuilder;
  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final Widget? seprater ;

  const ListBuilder({
    Key? key,
    required this.width,
    required this.height,
    required this.data,
    required this.itemBuilder,
    this.scrollDirection = Axis.horizontal,
    this.shrinkWrap = false,
    this.physics,
    this.seprater
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    if(scrollDirection == Axis.horizontal){
      return SizedBox(
        width: width,
        height: height,
        child: ListView.separated(
          itemCount: data.length,
          scrollDirection: scrollDirection,
          physics: physics,
          itemBuilder: (BuildContext context, int index) {
            return itemBuilder(context, index, data[index]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return seprater ?? const SizedBox.shrink();
          },
        ),
      );
      
    }
    
    
    
    
    
    return Expanded(
      child: SizedBox(
        width: width,
        child: ListView.separated(
          itemCount: data.length,
          scrollDirection: scrollDirection,
          physics: physics,
          itemBuilder: (BuildContext context, int index) {
            return itemBuilder(context, index, data[index]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return seprater ?? const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}




