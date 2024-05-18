import 'package:chat_app_material3/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final TextEditingController groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Done'),
        icon: const Icon(Iconsax.tick_circle_copy),
      ),
      appBar: AppBar(
        title: const Text('Create Group'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                       CircleAvatar(
                        radius: 40.r,
                      ),
                      Positioned(
                        top: 20,
                        bottom: 20,
                        right: 18,
                        left: 20,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add_a_photo),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                Expanded(
                    child: CustomTextFormField(
                        label: 'Group Name',
                        icon: Iconsax.user_octagon_copy,
                        controller: groupNameController))
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            const Divider(),
            SizedBox(
              height: 16.h,
            ),
            const Row(
              children: [
                Text('Member'),
                Spacer(),
                Text('0'),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            Expanded(
              child: ListView(
                children: [
                  CheckboxListTile(
                    title: const Text('Name'),
                    checkboxShape: const CircleBorder(),
                    value: true,
                    onChanged: (value) {},
                  ),
                  CheckboxListTile(
                    title: const Text('Name'),
                    checkboxShape: const CircleBorder(),
                    value: false,
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
