
import 'package:country_list_app/features/country/domain/entity/country_data.dart';
import '../data_source/country_data_source.dart';
import '../mapper/country_mapper.dart';
import '../model/country_model.dart';

abstract class CountryRepository {
  Future<List<CountryData>> fetchCountries();
}

class CountryRepositoryImpl implements CountryRepository {

  final CountryDataSource countryDataSource;

  final CountryMapper countryMapper;

  CountryRepositoryImpl({ required this.countryDataSource, required this.countryMapper});


  @override
  Future<List<CountryData>> fetchCountries() async {
    List<Country> countryList = await countryDataSource.fetchCountries();
    return countryMapper.mapToCountryData(countryList);
  }
}
