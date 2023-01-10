import 'package:equatable/equatable.dart';

enum SignupStatus { initial, submitting, success, error }

class SignupState extends Equatable {
  final String name;
  final String emailAddress;
  final String password;
  final SignupStatus status;

  const SignupState({
    required this.name,
    required this.emailAddress,
    required this.password,
    required this.status,
  });

  factory SignupState.initial() {
    return const SignupState(
      name: '',
      emailAddress: '',
      password: '',
      status: SignupStatus.initial,
    );
  }

  @override
  List<Object> get props => [name, emailAddress, password, status];

  SignupState copyWithe({
    String? name,
    String? emailAddress,
    String? password,
    SignupStatus? status,
  }) {
    return SignupState(
        name: name ?? this.name,
        emailAddress: emailAddress ?? this.emailAddress,
        password: password ?? this.password,
        status: status ?? this.status);
  }
}
