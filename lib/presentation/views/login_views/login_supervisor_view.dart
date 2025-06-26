import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ticketzone/presentation/providers/initial_loading_provider.dart';
import 'package:ticketzone/presentation/providers/login/login_provider.dart';
import 'package:ticketzone/presentation/widgets/shared/custom_text_form_field.dart';

class LoginSupervisorView extends ConsumerWidget {
  const LoginSupervisorView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(loginFormProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'Login Supervisor',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 40),
          CustomTextFormField(
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
            onChanged: ref.read(loginFormProvider.notifier).onEmailChange,
            errorMessage:
                loginForm.isFormPosted ? loginForm.email.errorMessage : null,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            label: 'Password',
            obscureText: true,
            onChanged: ref.read(loginFormProvider.notifier).onPasswordChanged,
            errorMessage:
                loginForm.isFormPosted ? loginForm.password.errorMessage : null,
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: FilledButton(
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () async {
                ref.read(loadingProvider.notifier).update((state) => true);
                await ref.read(loginFormProvider.notifier).onFormSubmit();
                final isValid = ref.watch(loginFormProvider).isValid;
                ref.read(loadingProvider.notifier).update((state) => false);
                if (isValid) context.go('/homeSupervisor');
              },
              child: Text('Login'),
            ),
          ),
          const SizedBox(height: 60),
          const Text("Aren't you a supervisor?"),
          TextButton(
            onPressed: () => context.go('/'),
            child: const Text('Return to login'),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
