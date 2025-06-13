import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          
          child: Row(
            children: [
              Image.network(
                'https://icon-library.com/images/free-ticket-icon/free-ticket-icon-0.jpg',
                width: 20,
                height: 20,
                color: colors.primary,
              ),
              const SizedBox(width: 5),
              Text(
                'TicketZone',
                style: titleStyle

              ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),

            ],
          ),
        ),
      ),
    );
  }
}