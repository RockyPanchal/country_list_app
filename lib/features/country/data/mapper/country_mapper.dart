import 'package:country_list_app/features/country/data/model/country_model.dart';
import 'package:country_list_app/features/country/domain/entity/country_data.dart';

abstract class CountryMapper{
  List<CountryData> mapToCountryData(List<Country> countryList);
}


class CountryMapperImpl implements CountryMapper{
  @override
  List<CountryData> mapToCountryData(List<Country> countryList) {
   return  countryList.map((element) => CountryData(countryName: element.countryName, region: element.region)).toList();
  }

}