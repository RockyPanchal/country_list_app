import 'package:country_list_app/features/country/data/repo/country_repository.dart';
import '../entity/country_data.dart';

abstract class CountriesUseCase {
  Future<List<CountryData>> execute();
}

class CountriesUseCaseImpl implements CountriesUseCase {
  final CountryRepository repository;

  CountriesUseCaseImpl(this.repository);

  @override
  Future<List<CountryData>> execute() async {
    return await repository.fetchCountries();
  }
}
