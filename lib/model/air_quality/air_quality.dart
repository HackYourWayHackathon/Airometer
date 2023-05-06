import 'coord.dart';
import 'list.dart';

class AirQuality {
  Coord? coord;
  List<Llist>? list;

  AirQuality({this.coord, this.list});

  factory AirQuality.fromJson(Map<String, dynamic> json) => AirQuality(
        coord: json['coord'] == null
            ? null
            : Coord.fromJson(json['coord'] as Map<String, dynamic>),
        list: (json['list'] as List<dynamic>?)
            ?.map((e) => Llist.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'coord': coord?.toJson(),
        'list': list?.map((e) => e.toJson()).toList(),
      };
}
