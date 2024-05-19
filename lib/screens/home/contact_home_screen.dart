import 'package:chat_app_material3/screens/contacts/contact_card.dart';
import 'package:chat_app_material3/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ContactHomeScreen extends StatefulWidget {
  const ContactHomeScreen({super.key});

  @override
  State<ContactHomeScreen> createState() => _ContactHomeScreenState();
}

class _ContactHomeScreenState extends State<ContactHomeScreen> {
  final TextEditingController contactController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          isSearch
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isSearch = false;
                    });
                  }, icon: const Icon(Iconsax.close_circle_copy))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      isSearch = true;
                    });
                  }, icon: const Icon(Iconsax.search_normal_1_copy))
        ],
        title: isSearch
            ? Row(
                children: [
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search by Name',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              )
            : const Text('My Contacts'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Iconsax.minus_copy,
                      size: 60,
                    ),
                    Row(
                      children: [
                        Text(
                          'Enter Friend Email',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const Spacer(),
                        IconButton.filled(
                            onPressed: () {},
                            icon: const Icon(Iconsax.scan_barcode_copy))
                      ],
                    ),
                    CustomTextFormField(
                      controller: contactController,
                      icon: Iconsax.direct_copy,
                      label: 'Email',
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer),
                      child: const Center(
                        child: Text('Add Contact'),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Iconsax.personalcard_copy),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const ContactCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
