import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ticketzone/domain/entities/db_tickets_bought_entity.dart';
import 'package:ticketzone/presentation/providers/database/db_tickets_bought_provider.dart';

class ScannerQRScreen extends ConsumerStatefulWidget {
  const ScannerQRScreen({super.key});

  @override
  ScannerQRScreenState createState() => ScannerQRScreenState();
}

class ScannerQRScreenState extends ConsumerState<ScannerQRScreen> {
  Barcode? _barcode;

  @override
  void initState() {
    super.initState();
    ref.read(getTicketsBoughtProvider.notifier).loadTicketsBought();
  }

  Widget _barcodePreview(Barcode? value,List<DbTicketsBoughtEntity>  tickets) {
    if (value == null) {
      return const Text(
        'Scan something!',
        overflow: TextOverflow.fade,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      );
    }

    print('Barcode detected: ${value.rawValue}');


    if(tickets.map((e) => e.ticketId).contains(value.rawValue)) {
      return FilledButton(
          onPressed: () {
            context.pop();
          },
          child: const Text('Verified Ticket'),
    );
    } 
    if(value.rawValue == 'q'){
      return Text(
            'This ticket was already used',
            style: const TextStyle(color: Colors.white,
            fontSize: 20, fontWeight: FontWeight.bold),     
      );

    }
    return Text(
      'This ticket is not part of our events.',
      style: const TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold),
    );
     
  }

  void _handleBarcode(BarcodeCapture barcodes) {
    if (mounted) {
      setState(() {
        _barcode = barcodes.barcodes.firstOrNull;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final tickets = ref.watch(getTicketsBoughtProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Tickets Scanner',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),), centerTitle: true),
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
                  Expanded(child: Center(child: _barcodePreview(_barcode,tickets ))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
