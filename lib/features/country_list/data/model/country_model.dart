class CountryListResponse {
  final String status;
  final int statusCode;
  final String version;
  final String access;
  final dynamic data;

  CountryListResponse({
    required this.status,
    required this.statusCode,
    required this.version,
    required this.access,
    required this.data,
  });

  factory CountryListResponse.fromJson(Map<String, dynamic> json) {
    return CountryListResponse(
      status: json['status'],
      statusCode: json['status-code'],
      version: json['version'],
      access: json['access'],
      data: json['data'] ,
    );
  }
}

class Country {
  final String countryCode;
  final String countryName;
  final String region;
  Country({
    required this.countryCode,
    required this.countryName,
    required this.region,
  });
  factory Country.fromJson(String code, Map<String, dynamic> json) {
    return Country(
      countryCode: code,
      countryName: json['country'],
      region: json['region'],
    );
  }
}