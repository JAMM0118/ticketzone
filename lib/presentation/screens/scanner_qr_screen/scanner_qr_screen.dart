import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ticketzone/presentation/helpers/helpers_scanner_qr.dart';
import 'package:ticketzone/presentation/providers/database/db_tickets_bought_provider.dart';
import 'package:ticketzone/presentation/providers/database/db_users_provider.dart';
import 'package:ticketzone/presentation/providers/helpers_providers.dart';
import 'package:ticketzone/presentation/widgets/shared/processing_loader.dart';

class ScannerQRScreen extends ConsumerStatefulWidget {
  const ScannerQRScreen({super.key});

  @override
  ScannerQRScreenState createState() => ScannerQRScreenState();
}

class ScannerQRScreenState extends ConsumerState<ScannerQRScreen> {
  
  @override
  void initState() {
    super.initState();
    ref.read(getTicketsBoughtProvider.notifier).loadTicketsBought();
    ref.read(getAllUsersProvider.notifier).loadAllUsers();
  }

  void _handleBarcode(BarcodeCapture barcodes ) {
    if (mounted) {
        ref.read(barCodeProvider.notifier).update((_) => barcodes.barcodes.firstOrNull);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tickets = ref.watch(getTicketsBoughtProvider);
    final user = ref.watch(getAllUsersProvider);
    final loading = ref.watch(loadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tickets Scanner',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          MobileScanner(onDetect: _handleBarcode),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 100,
              color: const Color.fromRGBO(0, 0, 0, 0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Center(
                      child: barcodePreview(tickets, user, ref, context),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (loading) const ProcessingLoader(message: 'Verifying ticket...'),
        ],
      ),
    );
  }
}
