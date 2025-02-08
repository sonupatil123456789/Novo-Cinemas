




import 'package:equatable/equatable.dart';

import 'MallLocationModel.dart';




class ShowTimesDataModel extends Equatable {
  final Map<String, MallLocationModel>? showTimesData;

  const ShowTimesDataModel({this.showTimesData});



  ShowTimesDataModel copyWith({
    Map<String, MallLocationModel>? showTimesData,
  }) {
    return ShowTimesDataModel(
      showTimesData: showTimesData ?? this.showTimesData,
    );
  }


  @override
  List<Object?> get props => [showTimesData];

  @override
  String toString() {
    return 'ShowTimesDataModel(showTimesData: $showTimesData)';
  }
}