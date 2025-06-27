import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ticketzone/presentation/providers/helpers_providers.dart';
import 'package:ticketzone/presentation/views/login_views/login_view.dart';
import 'package:ticketzone/presentation/widgets/shared/processing_loader.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context,ref) {

    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final loading = ref.watch(loadingProvider);
    
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(2, 25, 41, 1),
        body: Stack(
          children:[ SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox( height: 80 ),
                  Image.asset('assets/images/logo.png',height: 150,),
                  const SizedBox( height: 20 ),
                  FadeInRight(
                    child: Container(
                      height: size.height - 250, 
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(100),bottomLeft: Radius.circular(160))
                      ),
                      child: const LoginView(),
                    ),
                  )
                ],
              ),
          ),
          Positioned(
            top: 40,
            child: FadeIn(
              child: IconButton(
                icon: const Icon(Icons.admin_panel_settings, color: Colors.white),
                onPressed: () => context.go('/loginSupervisor'),
              ),
            ),
          ),
          if(loading) const ProcessingLoader(message: 'Logging in...')
        ]
        )
      ),
    );
  }
}
