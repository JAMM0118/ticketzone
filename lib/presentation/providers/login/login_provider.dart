import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:ticketzone/domain/entities/db_user_entity.dart';
import 'package:ticketzone/presentation/providers/database/db_auth_provider.dart';
import '../../widgets/shared/infrastructure/inputs/inputs.dart';

final loginFormProvider = StateNotifierProvider.autoDispose<LoginFormNotifier,LoginFormState>((ref) {

  final loginUserCallback = ref.watch(getUserToLoginProvider.notifier).login;

  return LoginFormNotifier(
    loginUserCallback:loginUserCallback
  );
});

class LoginFormNotifier extends StateNotifier<LoginFormState> {

  final Function(DbUserEntity userEntity) loginUserCallback;

  LoginFormNotifier({
    required this.loginUserCallback,
  }): super( LoginFormState() );
  
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
    
    await loginUserCallback( DbUserEntity(email: state.email.value, password: state.password.value));
  }

  _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    state = state.copyWith(
      isFormPosted: true,
      email: email,
      password: password,
      isValid: Formz.validate([ email, password ])
    );
  }
}
class LoginFormState {

  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;

  LoginFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure()
  });

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
  }) => LoginFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    email: email ?? this.email,
    password: password ?? this.password,
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
''';
  }
}