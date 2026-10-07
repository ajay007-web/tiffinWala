import 'package:equatable/equatable.dart';
import '../../../data/models/user_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthOtpSent extends AuthState {
  final String phone;
  final int resendCountdown;
  final bool canResend;
  final bool isVerifying;
  final String? error;

  const AuthOtpSent({
    required this.phone,
    this.resendCountdown = 30,
    this.canResend = false,
    this.isVerifying = false,
    this.error,
  });

  AuthOtpSent copyWith({
    String? phone,
    int? resendCountdown,
    bool? canResend,
    bool? isVerifying,
    String? error,
  }) {
    return AuthOtpSent(
      phone: phone ?? this.phone,
      resendCountdown: resendCountdown ?? this.resendCountdown,
      canResend: canResend ?? this.canResend,
      isVerifying: isVerifying ?? this.isVerifying,
      error: error,
    );
  }

  @override
  List<Object?> get props => [phone, resendCountdown, canResend, isVerifying, error];
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class Authenticated extends AuthState {
  final UserModel user;

  const Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
