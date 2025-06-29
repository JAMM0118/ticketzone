import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ticketzone/presentation/helpers/helpers.dart';
import 'package:ticketzone/presentation/providers/login/login_provider.dart';
import 'package:ticketzone/presentation/widgets/shared/custom_text_form_field.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(loginFormProvider);
    goHome()=> context.go('/home'); 
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          const SizedBox( height: 20 ),
          Text('Login', style:TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary
          ) ),
          const SizedBox( height: 40 ),
          CustomTextFormField(
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
            onChanged: ref.read(loginFormProvider.notifier).onEmailChange,
            errorMessage: loginForm.isFormPosted ?
               loginForm.email.errorMessage 
               : null,
          ),
          const SizedBox( height: 30 ),
          CustomTextFormField(
            label: 'Password',
            obscureText: true,
            onChanged: ref.read(loginFormProvider.notifier).onPasswordChanged,
            errorMessage: loginForm.isFormPosted ?
               loginForm.password.errorMessage 
               : null,
          ),   
          const SizedBox( height: 30 ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: FilledButton(          
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () async{
                verifiedFormLogin(ref: ref);
                if (loginForm.isValid) {
                  loadingLogin(ref: ref, go:'usuario'); 
                  await Future.delayed(const Duration(seconds: 1));
                  isNotLoading(ref: ref);
                  goHome();
                }        
              },
              child: Text('Login'),           
            )
          ),
          const SizedBox( height: 60 ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?"),
              TextButton(
                onPressed: ()=> context.go('/register'), 
                child: const Text('Create one')
              )
            ],
          ),
          const Spacer( flex: 2),
        ],
      ),
    );
  }
}