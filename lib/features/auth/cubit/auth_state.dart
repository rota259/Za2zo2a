import 'package:equatable/equatable.dart';

import '../data/models/auth_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Boot: we don't yet know if there's a valid session.
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// A request (restore/login/register/delete) is in flight. Used to disable
/// submit buttons and prevent double-submit.
class AuthLoading extends AuthState {
  const AuthLoading();
}

class Authenticated extends AuthState {
  final UserModel user;
  const Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}

class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}
