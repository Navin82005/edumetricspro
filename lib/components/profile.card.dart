import 'package:edumetricspro/animations/navigationAnimation.dart';
import 'package:edumetricspro/components/profile.student.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String profileImageUrl;
  final String name;
  final String rollNumber;
  final bool isActive;

  const ProfileCard({
    required this.profileImageUrl,
    required this.name,
    required this.rollNumber,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [
              Colors.pink,
              Colors.deepPurple,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Profile picture
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(profileImageUrl),
              ),
              const SizedBox(width: 16),
              // Name
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      (isActive)
                          ? const Padding(
                              padding: EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                              child: Icon(
                                Icons.circle,
                                color: Colors.green,
                                size: 12.0,
                              ),
                            )
                          : const Padding(
                              padding: EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                              child: Icon(
                                Icons.circle,
                                color: Colors.redAccent,
                                size: 12.0,
                              ),
                            ),
                    ],
                  ),
                  Text(
                    rollNumber.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    print("View Profile");
                    Navigator.of(context).push(SlideLiftRoute(
                        child: StudentProfile(
                            name: name, rollNumber: rollNumber)));
                  },
                  icon: Icon(Icons.open_in_new))
            ],
          ),
        ),
      ),
    );
  }
}
