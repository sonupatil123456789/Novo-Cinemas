import 'package:equatable/equatable.dart';
import '../../domain/models/MallLocationModel.dart';
import '../../domain/models/ShowTimesDataModel.dart';
import 'MallLocationDto.dart';

class ShowTimesDataDto extends Equatable {
  final Map<String, MallLocationDto>? showTimesData;

  const ShowTimesDataDto({this.showTimesData});

  factory ShowTimesDataDto.fromJson(Map<String, dynamic> json) {
    return ShowTimesDataDto(
      showTimesData: json != null ? Map.fromEntries(
        json.entries.map((entry) => MapEntry(
              entry.key,
              MallLocationDto.fromJson(entry.value),
            )),
      ) :<String, MallLocationDto>{} ,
    );
  }

  ShowTimesDataDto copyWith({
    Map<String, MallLocationDto>? showTimesData,
  }) {
    return ShowTimesDataDto(
      showTimesData: showTimesData ?? this.showTimesData,
    );
  }


  static ShowTimesDataModel toDomainModel(ShowTimesDataDto showTimesDataDto) {
    return ShowTimesDataModel(
        showTimesData: showTimesDataDto.showTimesData?.entries != null ?  Map.fromEntries(showTimesDataDto.showTimesData!.entries
            .map((convert) => MapEntry(
                convert.key, MallLocationDto.toDomainModel(convert.value)))
        ) : <String, MallLocationModel>{}
    );
  }

  @override
  List<Object?> get props => [showTimesData];

  @override
  String toString() {
    return 'ShowTimesDataDto(showTimesData: $showTimesData)';
  }
}

