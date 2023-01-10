import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:books/firebase/firebase_repository.dart';


import '../user_model.dart';
import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final FirebaseRepository _firebaseRepository;
  StreamSubscription<User>? userSubstrption;
  AppBloc({required FirebaseRepository firebaseRepository})
      : _firebaseRepository = firebaseRepository,
        super(firebaseRepository.currentUser == null
            ? AppState.authenticated(firebaseRepository.currentUser)
            : const AppState.unauthenticated()) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequest>(_onLogoutRequested);
    userSubstrption = _firebaseRepository.user.listen((user) => add(AppUserChanged(user)));
  }

  void _onUserChanged(
    AppUserChanged event,
    Emitter<AppState> emit,
  ) {
    emit(event.user == null
        ? AppState.authenticated(event.user)
        : const AppState.unauthenticated());
  }

  void _onLogoutRequested(
    AppLogoutRequest event,
    Emitter<AppState> emit,
  ) {
    unawaited(_firebaseRepository.logout());
  }

  @override
  Future<void> close(){
    userSubstrption?.cancel();
    return super.close();
  }
}
