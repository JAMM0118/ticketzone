import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ticketzone/presentation/providers/helpers_providers.dart';

class HomeSupervisorScreen extends ConsumerWidget {
  const HomeSupervisorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Welcome Supervisor',style: TextStyle(fontWeight: FontWeight.bold), ),
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          ref.read(barCodeProvider.notifier).update((_) => null);
          context.push('/scannerQR');
        },
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 70),
              Image.asset('assets/images/logo.png',width: 200,height: 200,),
              const SizedBox(height: 20),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Theme.of(context).colorScheme.primary,strokeAlign: 2,),
                  borderRadius: BorderRadius.circular(30),),
                margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10,),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(Icons.qr_code_scanner,size: 40,color: Theme.of(context).colorScheme.primary,),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Scan Event QR Code',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600,),),
                            const SizedBox(height: 5),
                            Text('Tap to scan a QR code to verify that you are registered for the event',
                              style: const TextStyle(fontSize: 14,color: Colors.grey,),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Theme.of(context).colorScheme.primary),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              FilledButton(onPressed: () => context.go('/'),child: const Text('Logout')),
            ],
          ),
        ),
      ),
    );
  }
}
