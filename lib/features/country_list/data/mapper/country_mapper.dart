import 'package:country_list_app/features/country_list/data/model/country_model.dart';
import 'package:country_list_app/features/country_list/domain/entity/country_entity.dart';

abstract class CountryMapper{
  List<CountryEntity> mapToCountryEntity(List<Country> countryList);
}


class CountryMapperImpl implements CountryMapper{
  @override
  List<CountryEntity> mapToCountryEntity(List<Country> countryList) {
   return  countryList.map((element) => CountryEntity(countryName: element.countryName)).toList();
  }

}