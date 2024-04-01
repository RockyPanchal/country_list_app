import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:country_list_app/core/api/api_provider.dart';
import 'package:country_list_app/core/network/network_connectivity.dart';
import 'package:country_list_app/features/country/data/data_source/country_data_source.dart';
import 'package:country_list_app/features/country/data/mapper/country_mapper.dart';
import 'package:country_list_app/features/country/data/repo/country_repository.dart';
import 'package:country_list_app/features/country/domain/use_cases/countries_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

registerDependency(){
  // Initialize GetIt instance
  final getIt = GetIt.instance;

  // Register dependencies
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());
  getIt.registerLazySingleton<NetworkConnectivity>(() => NetworkConnectivityImpl(getIt<Connectivity>()));
  getIt.registerLazySingleton<ApiProvider>(() => ApiProviderImpl(getIt<NetworkConnectivity>(),Client()));
  getIt.registerLazySingleton<CountryDataSource>(() => CountryDataSourceImpl(getIt<ApiProvider>()));
  getIt.registerLazySingleton<CountryMapper>(() => CountryMapperImpl());
  getIt.registerLazySingleton<CountryRepository>(() => CountryRepositoryImpl(countryDataSource: getIt<CountryDataSource>(), countryMapper: getIt<CountryMapper>()));
  getIt.registerLazySingleton<CountriesUseCase>(() => CountriesUseCaseImpl(getIt<CountryRepository>()));
}