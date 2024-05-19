import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: const Text('Name'),
        trailing: IconButton(onPressed: (){}, icon: const Icon(Iconsax.messages_1_copy),),
      ),
    );
  }
}
