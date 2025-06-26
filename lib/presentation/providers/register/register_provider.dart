import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:ticketzone/domain/entities/db_user_entity.dart';
import 'package:ticketzone/presentation/providers/database/db_auth_provider.dart';
import '../../widgets/shared/infrastructure/inputs/inputs.dart';

final registerFormProvider = StateNotifierProvider.autoDispose<RegisterFormNotifier,RegisterFormState>((ref) {

  final registerUserCallback = ref.watch(registerUserProvider.notifier).registerUser;
  
  return RegisterFormNotifier(
    registerUserCallback:registerUserCallback
  );
});

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {

  final Function(DbUserEntity userEntity) registerUserCallback;

  RegisterFormNotifier({
    required this.registerUserCallback,
  }): super( RegisterFormState() );
  
  onFullNameChange( String value ) {
    final newFullName = FullName.dirty(value);
    state = state.copyWith(
      fullName: newFullName,
      isValid: Formz.validate([ newFullName, state.email, state.password ])
    );
  }

  onEmailChange( String value ) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([ newEmail, state.password ])
    );
  }

  onPasswordChanged( String value ) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([ newPassword, state.email ])
    );
  }

  onFormSubmit() async {
    _touchEveryField();
  
    if ( !state.isValid ) return;
    
    await registerUserCallback( DbUserEntity(email: state.email.value, password: state.password.value, fullName: state.fullName.value ) );
  }

  _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final fullName = FullName.dirty(state.fullName.value);

    state = state.copyWith(
      isFormPosted: true,
      email: email,
      password: password,
      fullName: fullName,
      isValid: Formz.validate([ email, password, fullName ])
    );
  }
}

class RegisterFormState {

  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;
  final FullName fullName;

  RegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.fullName = const FullName.pure(),
  });

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    FullName? fullName,
    Password? password,
  }) => RegisterFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    email: email ?? this.email,
    password: password ?? this.password,
    fullName: fullName ?? this.fullName,
  );

  @override
  String toString() {
    return '''
  LoginFormState:
    isPosting: $isPosting
    isFormPosted: $isFormPosted
    isValid: $isValid
    email: $email
    password: $password
    name: $fullName
''';
  }
}