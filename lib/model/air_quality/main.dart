class Main {
  int? aqi;

  Main({this.aqi});

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        aqi: json['aqi'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'aqi': aqi,
      };
}
