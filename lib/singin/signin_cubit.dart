import 'package:bloc/bloc.dart';
import 'package:books/firebase/firebase_repository.dart';
import 'package:books/singin/signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  final FirebaseRepository _firebaseRepository;
  SigninCubit(this._firebaseRepository) : super(SigninState.initial());

  void emailChanged(String value) => emit(state.copyWithe(emailAddress: value, status: SigninStatus.initial));
  void passwordChanged(String value) => emit(state.copyWithe(password: value, status: SigninStatus.initial));

  Future<void> signIn() async {
    if(state.status == SigninStatus.submitting) return;
    emit(state.copyWithe(status: SigninStatus.submitting));
    try{
      _firebaseRepository.signin(emailAddress: state.emailAddress, password: state.password);
      emit(state.copyWithe(status: SigninStatus.success));
    }catch (_){

    }
  }

}
