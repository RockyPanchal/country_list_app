import 'dart:convert';
import 'package:country_list_app/core/api/api_exception.dart';
import 'package:country_list_app/core/api/api_provider.dart';
import 'package:country_list_app/core/network/network_exception.dart';
import '../model/country_model.dart';

abstract class CountryDataSource {
  Future<List<Country>> fetchCountries();
}

class CountryDataSourceImpl implements CountryDataSource {

  final ApiProvider apiProvider;

  CountryDataSourceImpl(this.apiProvider);

  static const String baseUrl = 'https://api.first.org/data/v1/countries';

  @override
  Future<List<Country>> fetchCountries() async {
      try {
        final apiResponse = await apiProvider.get(baseUrl);
        if (apiResponse.statusCode == 200) {
          CountryListResponse countryListResponse = CountryListResponse.fromJson(jsonDecode(apiResponse.data));
          List<Country> countries = [];
          Map<String, dynamic> data = countryListResponse.data;
          data.forEach((key, value) {
            countries.add(Country.fromJson(key, value));
          });
          return countries;
        }else{
          throw ApiException('Country Data not found');
        }
      } on NetworkException catch (e){
        throw NetworkException(e.toString());
      } catch (error) {
        throw ApiException('Something went wrong, please try again');
      }
  }
}
