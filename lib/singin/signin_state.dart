import 'package:equatable/equatable.dart';

enum SigninStatus { initial, submitting, success, error }

class SigninState extends Equatable {
  final String emailAddress;
  final String password;
  final SigninStatus status;

  const SigninState({
    required this.emailAddress,
    required this.password,
    required this.status,
  });

  factory SigninState.initial() {
    return const SigninState(
      emailAddress: '',
      password: '',
      status: SigninStatus.initial,
    );
  }

  @override
  List<Object> get props => [emailAddress, password, status];

  SigninState copyWithe({
    String? emailAddress,
    String? password,
    SigninStatus? status,
  }) {
    return SigninState(
        emailAddress: emailAddress ?? this.emailAddress,
        password: password ?? this.password,
        status: status ?? this.status);
  }
}

