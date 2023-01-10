import 'package:books/firebase/firebase_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/app.dart';
import 'app/bloc_observer.dart';
import 'firebase_options.dart';

Future<void> main() async {
  return BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      final firebaseRepository = FirebaseRepository();
      await firebaseRepository.user.first;
      runApp(App(firebaseRepository: firebaseRepository));
    },
    blocObserver: AppBlocObserver(),
  );
}