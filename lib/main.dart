import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'core/di/injection.dart';
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
