import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticketzone/presentation/providers/helpers_providers.dart';
import 'package:ticketzone/presentation/views/register_view/register_view.dart';
import 'package:ticketzone/presentation/widgets/shared/processing_loader.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context,ref) {

    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Color.fromRGBO(2, 25, 41, 1);
    
    final loading = ref.watch(loadingProvider);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
        body:  Stack(
          children: [
            SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox( height: 80 ),
                    Image.asset('assets/images/logo.png',height: 150),
                    const SizedBox( height: 20 ),
                    FadeInLeft(
                      child: Container(
                        height: size.height - 250, 
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(topRight: Radius.circular(100),bottomRight: Radius.circular(160)),
                        ),
                        child: const RegisterView(),
                      ),
                    )
                  ],
                ),
              ),
              if (loading) const ProcessingLoader(message: 'Creating account...'),
          ],
        )  
      ),
    );
  }
}
