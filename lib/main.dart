import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticketzone/config/router/app_router.dart';
import 'package:ticketzone/config/theme/app_theme.dart';

Future<void> main() async{
  
  await dotenv.load(fileName: '.env');
  
  runApp( const ProviderScope(child:MyApp())  );

} 

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context, ref) {
    return  MaterialApp.router(
      title: 'TicketZone',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
    );
}
}
