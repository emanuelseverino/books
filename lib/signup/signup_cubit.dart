import 'package:bloc/bloc.dart';
import 'package:books/firebase/firebase_repository.dart';
import 'package:books/signup/singup_state.dart';
import 'package:books/singin/signin_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final FirebaseRepository _firebaseRepository;

  SignupCubit(this._firebaseRepository) : super(SignupState.initial());

  void nameChanged(String value) =>
      emit(state.copyWithe(name: value, status: SignupStatus.initial));

  void emailChanged(String value) =>
      emit(state.copyWithe(emailAddress: value, status: SignupStatus.initial));

  void passwordChanged(String value) =>
      emit(state.copyWithe(password: value, status: SignupStatus.initial));

  Future<void> signUp() async {
    if (state.status == SigninStatus.submitting) return;
    emit(state.copyWithe(status: SignupStatus.submitting));
    try {
      _firebaseRepository.signup(
          name: state.name,
          emailAddress: state.emailAddress,
          password: state.password);
      emit(state.copyWithe(status: SignupStatus.success));
    } catch (_) {}
  }
}
