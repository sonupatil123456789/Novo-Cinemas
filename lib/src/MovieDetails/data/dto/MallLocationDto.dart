


import 'package:equatable/equatable.dart';
import '../../domain/models/MallLocationModel.dart';
import '../../../../entities/models/ShowTimeDetailsModel.dart';
import '../../../../entities/dto/ShowTimeDetailsDto.dart';
import 'ShowTimeDataDto.dart';

class MallLocationDto extends Equatable {
  final Map<String,List<ShowTimeDetailsDto>>? mallLocation;

  const MallLocationDto({this.mallLocation});

  factory MallLocationDto.fromJson(Map<String, dynamic> json) {
    return  MallLocationDto(mallLocation :json != null ? Map.fromEntries(
      json.entries.map((entry) => MapEntry(
        entry.key,
        (entry.value as List<dynamic>).map((toElement)=> ShowTimeDetailsDto.fromJson(toElement)).toList(),
      )),
    ) : <String, List<ShowTimeDetailsDto>>{});
  }



  MallLocationDto copyWith({
    Map<String,List<ShowTimeDetailsDto>>? mallLocation,
  }) {
    return MallLocationDto(
      mallLocation: mallLocation ?? this.mallLocation,
    );
  }

  static MallLocationModel toDomainModel(MallLocationDto mallLocationDto) {
    return MallLocationModel(
        mallLocation:mallLocationDto.mallLocation?.entries != null ?  Map.fromEntries(mallLocationDto.mallLocation!.entries.map((toElement) =>
            MapEntry(toElement.key, toElement.value.map((toElement)=>ShowTimeDetailsDto.toDomainModel(toElement)).toList())
        ) ) : <String, List<ShowTimeDetailsModel>>{}
    );
  }

  @override
  List<Object?> get props => [mallLocation];

  @override
  String toString() {
    return 'MallLocationDto(mallLocation: $mallLocation)';
  }
}
