import 'package:country_list_app/features/country/presentation/bloc/country_bloc.dart';
import 'package:country_list_app/features/country/presentation/bloc/country_events.dart';
import 'package:country_list_app/features/country/presentation/bloc/country_states.dart';
import 'package:country_list_app/features/country/presentation/widgets/country_list_widget.dart';
import 'package:country_list_app/features/country/presentation/widgets/empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CountryScreen extends StatefulWidget {
  const CountryScreen({super.key});

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CountryBloc>(context).add(LoadCountriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:  Text('Countries',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w800),),
        toolbarHeight: 44.w,
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocConsumer<CountryBloc, CountryState>(
          listener: (context,state){
            if (state is CountryError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
              ));
            }
          },
          builder: (context, state) {
            if (state is CountryInitial || state is CountryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CountriesLoaded) {
              return state.countries.isEmpty ?
               const EmptyListWidget():
               CountryListWidget(countries: state.countries);
            } else {
              return const EmptyListWidget();
            }
          },
        ),
      ),
    );
  }
}
