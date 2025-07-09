import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/user.dart';
import 'LoginandSignup.dart' as login_signup;

class EditProfileScreen extends StatefulWidget {
  final User user;

  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _usernameController = TextEditingController(text: widget.user.username ?? '');
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phoneNumber ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setProfileImage(pickedFile.path);
      // Also update in-memory user map for persistence in this session
      if (userProvider.user != null) {
        final email = userProvider.user!.email;
        if (login_signup.users.containsKey(email)) {
          login_signup.users[email]!['profileImagePath'] = pickedFile.path;
        }
      }
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      
      // Create updated user
      final updatedUser = User(
        name: _nameController.text.trim(),
        username: _usernameController.text.trim(),
        email: _emailController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        profileImagePath: widget.user.profileImagePath,
        address: widget.user.address,
        city: widget.user.city,
        state: widget.user.state,
        zipCode: widget.user.zipCode,
      );

      // Update in UserProvider
      userProvider.setUser(updatedUser);

      // Update in-memory user map for persistence
      final oldEmail = widget.user.email;
      final newEmail = updatedUser.email;

      // Remove old entry and add new one
      if (login_signup.users.containsKey(oldEmail)) {
        final userData = login_signup.users[oldEmail]!;
        login_signup.users.remove(oldEmail);
        login_signup.users[newEmail] = {
          'name': updatedUser.name,
          'username': updatedUser.username ?? '',
          'email': updatedUser.email,
          'phoneNumber': updatedUser.phoneNumber ?? '',
          'password': userData['password'] ?? '', // Keep the same password
          'profileImagePath': updatedUser.profileImagePath ?? '', // Handle nullable profileImagePath
          'address': userData['address'] ?? '',
          'city': userData['city'] ?? '',
          'state': userData['state'] ?? '',
          'zipCode': userData['zipCode'] ?? '',
        };
      }

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Personal information updated successfully!'),
            backgroundColor: Colors.green[600],
            duration: const Duration(seconds: 2),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating profile: $e'),
            backgroundColor: Colors.red[600],
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.red[600],
        foregroundColor: Colors.white,
        actions: [
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            )
          else
            TextButton(
              onPressed: _saveProfile,
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                             // Profile Picture Section
               Center(
                 child: Column(
                   children: [
                     GestureDetector(
                       onTap: _pickImage,
                       child: Stack(
                         alignment: Alignment.bottomRight,
                         children: [
                           CircleAvatar(
                             radius: 60,
                             backgroundImage: (widget.user.profileImagePath != null && 
                                             widget.user.profileImagePath!.isNotEmpty)
                                 ? FileImage(File(widget.user.profileImagePath!))
                                 : const AssetImage('assets/images/logo1.png') as ImageProvider,
                           ),
                           Container(
                             decoration: BoxDecoration(
                               color: Colors.white,
                               shape: BoxShape.circle,
                             ),
                             child: const Padding(
                               padding: EdgeInsets.all(4.0),
                               child: Icon(Icons.camera_alt, color: Colors.red, size: 22),
                             ),
                           ),
                         ],
                       ),
                     ),
                     const SizedBox(height: 16),
                     Text(
                       'Tap profile picture to change',
                       style: TextStyle(
                         color: Colors.grey[600],
                         fontSize: 14,
                       ),
                     ),
                   ],
                 ),
               ),
              const SizedBox(height: 32),

              // Name Field
              const Text(
                'Full Name',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Enter your full name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.person_outline),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your name';
                  }
                  if (value.trim().length < 2) {
                    return 'Name must be at least 2 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Email Field
              const Text(
                'Email Address',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter your email address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.email_outlined),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!_isValidEmail(value.trim())) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                             ),
               const SizedBox(height: 32),

               // Save Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[600],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          'Save Changes',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 