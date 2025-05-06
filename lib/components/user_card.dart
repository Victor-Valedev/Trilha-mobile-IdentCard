import 'package:flutter/material.dart';

import 'package:trilhamobileatvd/model/dto/user_response_dto.dart';

class UserCard extends StatelessWidget {
  final UserResponseDto user;
  const UserCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(12),
      tileColor: Colors.white,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          user.image,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ID ${user.id}',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.normal,
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '${user.firstName} ${user.lastName}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 10),
          Text(
            'Gender: ${user.gender}',
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
