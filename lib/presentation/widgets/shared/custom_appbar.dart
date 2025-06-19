import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: SizedBox(
        width: double.infinity,
        
        child: Row(
          children: [
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 5),
               child: Image.asset(
                'assets/images/ticket.jpg',
                width: 20,
                height: 20,
                color: colors.primary,),
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
    );
  }
}