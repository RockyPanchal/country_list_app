import 'package:country_list_app/features/country_list/domain/entity/country_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountryListWidget extends StatelessWidget {

  final List<CountryEntity> countries;

  const CountryListWidget({super.key, required this.countries});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: countries.length,
      shrinkWrap: true,
      padding:  EdgeInsets.symmetric(horizontal: 25.w),
      itemBuilder: (context, index) {
        final country = countries[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            country.countryName,style: TextStyle(fontSize: 14.sp),
          ),
        );
      },
    );
  }
}
