import 'package:equatable/equatable.dart';
import 'package:novocinema/src/ShowTime/data/dto/ShowTimeMallLocationDto.dart';
import 'package:novocinema/src/ShowTime/domain/models/ShowTimeMallLocationModel.dart';
import '../../domain/models/ShowTimeDataModel.dart';
import 'ShowTimeMoviesDto.dart';


class ShowTimesDataDto extends Equatable {
  final Map<String,ShowTimeMallLocationDto>? showTimesData;

  const ShowTimesDataDto({this.showTimesData});

  factory ShowTimesDataDto.fromJson(Map<String, dynamic> json) {
    return ShowTimesDataDto(
      showTimesData: json != null ? Map.fromEntries(
        json.entries.map((entry) => MapEntry(
              entry.key,
              ShowTimeMallLocationDto.fromJson(entry.value)
        )

        ),
      ) :<String, ShowTimeMallLocationDto>{}
    );
  }

  ShowTimesDataDto copyWith({
    Map<String,ShowTimeMallLocationDto>? showTimesData,
  }) {
    return ShowTimesDataDto(
      showTimesData: showTimesData ?? this.showTimesData,
    );
  }


  static ShowTimesDataModel toDomainModel(ShowTimesDataDto showTimesDataDto) {
    return ShowTimesDataModel(
        showTimesData: showTimesDataDto != null ? Map.fromEntries(
          showTimesDataDto.showTimesData!.entries.map((entry) => MapEntry(
              entry.key,
              ShowTimeMallLocationDto.toDomainModel(entry.value)
          )
          ),
        ) :<String, ShowTimeMallLocationModel>{}
    );
  }

  @override
  List<Object?> get props => [showTimesData];

  @override
  String toString() {
    return 'ShowTimesDataDto(showTimesData: $showTimesData)';
  }
}

