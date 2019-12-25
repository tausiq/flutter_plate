import 'package:meta/meta.dart';

@immutable
class RegisterState {
  final bool isFirstNameValid;
  final bool isLastNameValid;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isFirstNameValid && isLastNameValid && isEmailValid && isPasswordValid;

  RegisterState({
    @required this.isFirstNameValid,
    @required this.isLastNameValid,
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory RegisterState.empty() {
    return RegisterState(
      isFirstNameValid: true,
      isLastNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.loading() {
    return RegisterState(
      isFirstNameValid: true,
      isLastNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.failure() {
    return RegisterState(
      isFirstNameValid: true,
      isLastNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory RegisterState.success() {
    return RegisterState(
      isFirstNameValid: true,
      isLastNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  RegisterState update({
    isFirstNameValid: true,
    isLastNameValid: true,
    bool isEmailValid,
    bool isPasswordValid,
  }) {
    return copyWith(
      isFirstNameValid: isFirstNameValid,
      isLastNameValid: isLastNameValid,
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  RegisterState copyWith({
    bool isFirstNameValid,
    bool isLastNameValid,
    bool isEmailValid,
    bool isPasswordValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return RegisterState(
      isFirstNameValid: isFirstNameValid ?? this.isFirstNameValid,
      isLastNameValid: isLastNameValid ?? this.isLastNameValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is RegisterState &&
              runtimeType == other.runtimeType &&
              isFirstNameValid == other.isFirstNameValid &&
              isLastNameValid == other.isLastNameValid &&
              isEmailValid == other.isEmailValid &&
              isPasswordValid == other.isPasswordValid &&
              isSubmitting == other.isSubmitting &&
              isSuccess == other.isSuccess &&
              isFailure == other.isFailure;

  @override
  int get hashCode =>
      isFirstNameValid.hashCode ^
      isLastNameValid.hashCode ^
      isEmailValid.hashCode ^
      isPasswordValid.hashCode ^
      isSubmitting.hashCode ^
      isSuccess.hashCode ^
      isFailure.hashCode;

  @override
  String toString() {
    return 'RegisterState{isFirstNameValid: $isFirstNameValid, isLastNameValid: $isLastNameValid, isEmailValid: $isEmailValid, isPasswordValid: $isPasswordValid, isSubmitting: $isSubmitting, isSuccess: $isSuccess, isFailure: $isFailure}';
  }
}
