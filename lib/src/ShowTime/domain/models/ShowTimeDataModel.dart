import 'package:equatable/equatable.dart';
import 'package:novocinema/src/ShowTime/domain/models/ShowTimeMallLocationModel.dart';



class ShowTimesDataModel extends Equatable {
  final Map<String,ShowTimeMallLocationModel>? showTimesData;

  const ShowTimesDataModel({this.showTimesData});


  ShowTimesDataModel copyWith({
    Map<String,ShowTimeMallLocationModel>? showTimesData,
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

