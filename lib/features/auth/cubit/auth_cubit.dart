import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/mock/mock_user.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  Timer? _countdownTimer;

  AuthCubit() : super(const AuthInitial());

  void sendOtp(String phone) {
    emit(const AuthLoading());
    // Simulate network delay
    Future.delayed(const Duration(milliseconds: 600), () {
      emit(AuthOtpSent(phone: phone, resendCountdown: 30, canResend: false));
      _startCountdown(phone);
    });
  }

  void _startCountdown(String phone) {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state is AuthOtpSent) {
        final current = state as AuthOtpSent;
        if (current.resendCountdown > 1) {
          emit(current.copyWith(resendCountdown: current.resendCountdown - 1));
        } else {
          timer.cancel();
          emit(current.copyWith(resendCountdown: 0, canResend: true));
        }
      } else {
        timer.cancel();
      }
    });
  }

  void resendOtp() {
    if (state is AuthOtpSent) {
      final current = state as AuthOtpSent;
      emit(current.copyWith(resendCountdown: 30, canResend: false, error: null));
      _startCountdown(current.phone);
    }
  }

  Future<bool> verifyOtp(String otp) async {
    if (state is! AuthOtpSent) return false;
    final current = state as AuthOtpSent;

    emit(current.copyWith(isVerifying: true, error: null));
    await Future.delayed(const Duration(milliseconds: 800));

    // Any 6 digits or test 123456 accepted for demo
    if (otp.length == 6) {
      _countdownTimer?.cancel();
      emit(Authenticated(mockCurrentUser));
      return true;
    } else {
      emit(current.copyWith(
        isVerifying: false,
        error: 'Invalid 6-digit verification code. Please try again.',
      ));
      return false;
    }
  }

  void logout() {
    _countdownTimer?.cancel();
    emit(const AuthInitial());
  }

  @override
  Future<void> close() {
    _countdownTimer?.cancel();
    return super.close();
  }
}
