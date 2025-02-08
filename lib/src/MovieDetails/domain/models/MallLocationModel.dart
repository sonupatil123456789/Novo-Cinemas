


import 'package:equatable/equatable.dart';

import '../../../../entities/models/ShowTimeDetailsModel.dart';


class MallLocationModel extends Equatable {
  final Map<String,List<ShowTimeDetailsModel>>? mallLocation;

  const MallLocationModel({this.mallLocation});


  MallLocationModel copyWith({
    Map<String,List<ShowTimeDetailsModel>>? mallLocation
  }) {
    return MallLocationModel(
      mallLocation: mallLocation ?? this.mallLocation,
    );
  }


  @override
  List<Object?> get props => [mallLocation];

  @override
  String toString() {
    return 'MallLocationModel(mallLocation: $mallLocation)';
  }
}
