import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticketzone/presentation/providers/initial_loading_provider.dart';
import 'package:ticketzone/presentation/views/login_views/login_supervisor_view.dart';
import 'package:ticketzone/presentation/widgets/events/processing_loader.dart';

class LoginSupervisorScreen extends ConsumerWidget {
  const LoginSupervisorScreen({super.key});

  @override
  Widget build(BuildContext context,ref) {final size = MediaQuery.of(context).size;
    final loading = ref.watch(loadingProvider);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        
        backgroundColor: Color.fromRGBO(112, 36, 1, 1),
        body: Stack(
          children:[ SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox( height: 80 ),
                  Image.asset(
                    'assets/images/logo.png',
                    height: 150,
                  ),
                  const SizedBox( height: 20 ),
                  FadeInUp(
                    child: Container(
                      height: size.height - 250, 
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 2, 17, 46),
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(90), topRight: Radius.circular(90), 
                        bottomLeft: Radius.circular(120), bottomRight: Radius.circular(120))
                      ),
                      child: const LoginSupervisorView(),
                    ),
                  )
                ],
              ),
          ),
          if(loading) const ProcessingLoader(message: 'Logging in...')
        ]
        )
      ),
    );
  }
  }
