import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_parking_spaces/components/parking_spaces/bottom_navigator.dart';
import 'package:manage_parking_spaces/modules/history_parking_spaces/bloc/get_hisotry/gest_history_bloc.dart';
import 'package:manage_parking_spaces/modules/history_parking_spaces/bloc/set_history/set_history_bloc.dart';
import 'package:manage_parking_spaces/modules/manage_parking_spaces/bloc/check_first_access/check_first_access_bloc.dart';
import 'package:manage_parking_spaces/modules/manage_parking_spaces/bloc/manage_spaces/manage_spaces_bloc.dart';
import 'package:manage_parking_spaces/modules/manage_parking_spaces/bloc/set_total_spaces/set_total_spaces_bloc.dart';
import 'package:manage_parking_spaces/theme/app_colors.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<CheckFirstAccessBloc>(
          create: (context) => CheckFirstAccessBloc()),
      BlocProvider<SetTotalSpacesBloc>(
          create: (context) => SetTotalSpacesBloc()),
      BlocProvider<ManageSpacesBloc>(create: (context) => ManageSpacesBloc()),
      BlocProvider<SetHistoryBloc>(create: (context) => SetHistoryBloc()),
       BlocProvider<GestHistoryBloc>(create: (context) => GestHistoryBloc()),
    ],
    child: MaterialApp(
      theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            errorBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            disabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          appBarTheme: AppBarTheme(
              backgroundColor: AppColors.primaryColor,
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 18)),
          primaryColor: AppColors.primaryColor),
      home: const BottomNavigatorParkingSpaces(),
    ),
  ));
}
