import 'package:chat_app_material3/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class GroupEdit extends StatefulWidget {
  const GroupEdit({super.key});

  @override
  State<GroupEdit> createState() => _GroupEditState();
}

class _GroupEditState extends State<GroupEdit> {
  final TextEditingController groupNameController = TextEditingController();
@override
  void initState() {
  groupNameController.text = 'Name';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Done'),
        icon: const Icon(Iconsax.tick_circle_copy),
      ),
      appBar: AppBar(
        title: const Text('Edit Group'),
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
                      const CircleAvatar(
                        radius: 40,
                      ),
                      Positioned(
                        bottom: -20,
                        right: -20,
                        child: IconButton(
                          onPressed: () {},
                          icon:  IconButton.outlined(onPressed: (){},icon:Icon(Iconsax.edit_copy)),
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
                Text('Add Member'),
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
