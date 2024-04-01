import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:country_list_app/core/api/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'core/network/network_connectivity.dart';
import 'features/country/data/data_source/country_data_source.dart';
import 'features/country/data/repo/country_repository.dart';
import 'features/country/data/mapper/country_mapper.dart';
import 'features/country/domain/use_cases/countries_usecase.dart';
import 'features/country/presentation/bloc/country_bloc.dart';
import 'features/country/presentation/screens/country_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  registerDependency();
  runApp(const CountryApp());
}

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

class CountryApp extends StatelessWidget {
  const CountryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      child: MaterialApp(
        title: 'Country App',
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
          create: (context) => CountryBloc(countriesUseCase: GetIt.instance<CountriesUseCase>()),
          child: const CountryScreen(),
        ),
      ),
    );
  }
}
