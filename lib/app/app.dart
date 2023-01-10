import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../firebase/firebase_repository.dart';
import 'app_bloc.dart';
import 'app_view.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required FirebaseRepository firebaseRepository,
  }) : _firebaseRepository = firebaseRepository;

  final FirebaseRepository? _firebaseRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _firebaseRepository,
      child: BlocProvider(
        create: (_) => AppBloc(
          firebaseRepository: _firebaseRepository!,
        ),
        child: AppView(context: context),
      ),
    );
  }
}