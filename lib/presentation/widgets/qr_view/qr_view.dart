import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRView extends StatelessWidget {
  final String ticketId;
  const QRView({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.center,
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          strokeAlign: 2,
          color: Theme.of(context).colorScheme.primary,
        ),
        borderRadius: BorderRadius.circular(55),
      ),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text('Event Ticket', textAlign: TextAlign.center),
      contentPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      content: SizedBox(
        height: 250,
        width: 250,
        child: QrImageView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          data: ticketId,
          gapless: false,
          version: QrVersions.auto,
          dataModuleStyle: QrDataModuleStyle(
            dataModuleShape: QrDataModuleShape.square,
            color: Theme.of(context).colorScheme.primary,
          ),
          size: 200,
          eyeStyle: QrEyeStyle(
            eyeShape: QrEyeShape.square,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => context.pop(), child: Text('Close')),
      ],
    );
  }
}
