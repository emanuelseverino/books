import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String id;
  final String? name;
  final String email;
  final String? photo;

  const User({
    required this.id,
    this.name,
    required this.email,
    this.photo,
  });

  static const empty = User(
    id: '',
    name: '',
    email: '',
  );

  @override
  List<Object?> get props => [];

}

