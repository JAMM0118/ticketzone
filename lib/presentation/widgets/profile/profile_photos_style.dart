import 'package:flutter/material.dart';
import 'package:ticketzone/domain/entities/db_user_entity.dart';

class ProfilePhotosStyle extends StatelessWidget {
  const ProfilePhotosStyle({super.key,required this.userInSession,});

  final DbUserEntity userInSession;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 240,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                image: DecorationImage(
                  opacity: 0.5,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/profile_background.webp'),
                ),
              ),
    
              child: SizedBox(),
            ),
            Container(
              height: 5,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 170),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/profile.png',),
                  ),
                ),
                SizedBox(width: 2),
                Column(
                  children: [
                    SizedBox(height: 20),
                    Text(userInSession.fullName!,
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white,),
                    ),
                    const SizedBox(height: 5),
                    Text(userInSession.email,
                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
