class DataCovid {
  final int confirmed;
  final int recovered;
  final int deaths;
  DataCovid({
    required this.confirmed,
    required this.recovered,
    required this.deaths,
  });
  factory DataCovid.fromJson(Map<String, dynamic> json) {
    return DataCovid(
      confirmed: json['confirmed']['value'],
      recovered: json['recovered']['value'],
      deaths: json['deaths']['value'],
    );
  }
}