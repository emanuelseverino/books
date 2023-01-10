import 'package:books/app/routes.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'app_bloc.dart';
import 'app_state.dart';

class AppView extends StatelessWidget {
  const AppView({Key? key, required var context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.resolveWith((states) => Colors.black),
              foregroundColor:
              MaterialStateProperty.resolveWith((states) => Colors.white),
              shape: MaterialStateProperty.resolveWith(
                    (states) =>
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.transparent,
              ),
              overlayColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.black12,
              ),
              foregroundColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.black,
              ),
              side: MaterialStateProperty.resolveWith(
                    (states) => const BorderSide(width: 1),
              ),
              shape: MaterialStateProperty.resolveWith(
                    (states) =>
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
              ),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            border: InputBorder.none,
          )
      ),
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.appStatus),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
