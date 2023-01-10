import 'package:books/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:get/get.dart';

import '../user_model.dart';

class FirebaseRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  FirebaseRepository({firebase_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  var currentUser = User.empty;

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      print('FirebaseUser: $firebaseUser');
      print('${firebaseUser!.toUser}');
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      currentUser = user;
      return user;
    });
  }

  Future<void> signup({
    required String name,
    required String emailAddress,
    required String password,
  }) async {
    try {
      final credential = await firebase_auth.FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
     await credential.user!.updateDisplayName(name);
      Get.to(const HomePage());
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Senha muito fraca!', 'Escolha opções mais seguras.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Escolha outro e-mail!',
            'Este e-mail já esta cadastrado em nosso sistema.');
      }
    } catch (e) {
      Get.snackbar('Erro!', 'Contate o suporte.');
    }
  }

  Future<void> signin({
    required String emailAddress,
    required String password,
  }) async {
    try {
      await firebase_auth.FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      Get.to(const HomePage());
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          'E-mail não cadastrado',
          'Crie uma conta agora.',
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Senha errada', 'Digite sua senha corretamente.');
      }
    } catch (e) {
      Get.snackbar('Erro!', 'Contate o suporte.');
    }
  }

//
  Future<void> logout() async {
    try {
      await Future.wait([_firebaseAuth.signOut()]);
    } catch (e) {
      Get.snackbar('Tente outra vez', 'Houve um erro ao tentar deslogar o usuário.');
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, name: displayName, email: email!, photo: photoURL);
  }
}
