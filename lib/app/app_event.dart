import 'package:equatable/equatable.dart';

import '../user_model.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppLogoutRequest extends AppEvent {}

class AppUserChanged extends AppEvent {
  final User user;

  const AppUserChanged(this.user);

  @override
  List<Object> get props => [user];
}
