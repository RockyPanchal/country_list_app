import 'package:country_list_app/features/country/data/repo/country_repository.dart';
import '../entity/country_entity.dart';

abstract class CountriesUseCase {
  Future<List<CountryEntity>> execute();
}

class CountriesUseCaseImpl implements CountriesUseCase {
  final CountryRepository repository;

  CountriesUseCaseImpl(this.repository);

  @override
  Future<List<CountryEntity>> execute() async {
    return await repository.fetchCountries();
  }
}
