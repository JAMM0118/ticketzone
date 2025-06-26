import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ticketzone/presentation/providers/providers.dart';
import 'package:ticketzone/presentation/providers/register/register_provider.dart';
import 'package:ticketzone/presentation/widgets/shared/custom_text_form_field.dart';

class RegisterView extends ConsumerWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final registerForm = ref.watch(registerFormProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          const SizedBox( height: 20 ),
          Text('New account', style:TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary
          ) ),
          const SizedBox( height: 30 ),
          CustomTextFormField(
            label: 'Full Name',
            keyboardType: TextInputType.text,
            onChanged: ref.read(registerFormProvider.notifier).onFullNameChange,
            errorMessage: registerForm.isFormPosted ?
               registerForm.fullName.errorMessage 
               : null,
          ),
          const SizedBox( height: 30 ),
          CustomTextFormField(
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
            onChanged: ref.read(registerFormProvider.notifier).onEmailChange,
            errorMessage: registerForm.isFormPosted ?
               registerForm.email.errorMessage 
               : null,
          ),
          const SizedBox( height: 30 ),
          CustomTextFormField(
            label: 'Password',
            obscureText: true,
            onChanged: ref.read(registerFormProvider.notifier).onPasswordChanged,
            errorMessage: registerForm.isFormPosted ?
               registerForm.password.errorMessage 
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
              onPressed: ()async{
                ref.read(loadingProvider.notifier).update((state) => true);
                await ref.read(registerFormProvider.notifier).onFormSubmit();
                final isValid = ref.read(registerFormProvider).isValid;
                ref.read(loadingProvider.notifier).update((state) => false);
                if (isValid) context.go('/');    
              },
              child: Text('Create account' ),
            )
          ),
          const SizedBox( height: 30 ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Already have an account?'),
              TextButton(
                onPressed: (){
                  context.go('/'); 
                }, 
                child: const Text('Go in here')
              )
            ],
          ),
        ],
      ),
    );
  }
}