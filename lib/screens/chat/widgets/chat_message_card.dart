import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ChatMessageCard extends StatelessWidget {
  const ChatMessageCard({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          index % 2 == 0 ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        index % 2 == 0
            ? IconButton(
                onPressed: () {}, icon: const Icon(Iconsax.message_edit_copy))
            : const SizedBox(),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(index % 2 == 0 ? 16 : 0),
                bottomRight: Radius.circular(index % 2 == 0 ? 0 : 16),
                topRight: Radius.circular(16.r),
                topLeft: Radius.circular(16.r)),
          ),
          color: index % 2 == 0
              ? Theme.of(context).colorScheme.surface
              : Theme.of(context).colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Message uhfvytkuf'),
                  Row(
                    children: [
                      index % 2 == 0
                          ? const Icon(
                              Iconsax.tick_circle_copy,
                              size: 16,
                              color: Colors.blueAccent,
                            )
                          : const SizedBox(),
                      Text(
                        '04:03 pm',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                    ],
                    mainAxisSize: MainAxisSize.min,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
