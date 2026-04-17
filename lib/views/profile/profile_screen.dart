import 'package:flutter/material.dart';

import '../../core/extension/context_extension.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          Center(
            child: CircleAvatar(
              radius: 55,
              backgroundColor: Colors.grey.shade300,
              backgroundImage: const NetworkImage(
                'https://i.pravatar.cc/300', // dummy image
              ),
            ),
          ),

          const SizedBox(height: 20),

          Text('Vishal Prajapati', style: context.text.headlineLarge),

          const SizedBox(height: 6),

          Text('vishal@email.com', style: context.text.titleMedium),

          const SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildTile(
                    icon: Icons.person,
                    title: 'Edit Profile',
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  _buildTile(
                    icon: Icons.power_settings_new_outlined,
                    title: 'Logout',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
