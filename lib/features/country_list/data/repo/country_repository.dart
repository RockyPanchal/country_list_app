
import 'package:country_list_app/features/country_list/domain/entity/country_entity.dart';
import '../data_source/country_data_source.dart';
import '../mapper/country_mapper.dart';
import '../model/country_model.dart';

abstract class CountryRepository {
  Future<List<CountryEntity>> fetchCountries();
}

class CountryRepositoryImpl implements CountryRepository {

  final CountryDataSource countryDataSource;

  final CountryMapper countryMapper;

  CountryRepositoryImpl({ required this.countryDataSource, required this.countryMapper});


  @override
  Future<List<CountryEntity>> fetchCountries() async {
    List<Country> countryList = await countryDataSource.fetchCountries();
    return countryMapper.mapToCountryEntity(countryList);
  }
}
