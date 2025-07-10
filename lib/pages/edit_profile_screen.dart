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
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _zipCodeController;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _usernameController = TextEditingController(text: widget.user.username ?? '');
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phoneNumber ?? '');
    _addressController = TextEditingController(text: widget.user.address ?? '');
    _cityController = TextEditingController(text: widget.user.city ?? '');
    _zipCodeController = TextEditingController(text: widget.user.zipCode ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    // Email validation regex that only accepts .com domains
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.com$',
      caseSensitive: false,
    );
    
    // Check if email matches the pattern
    if (!emailRegex.hasMatch(email)) {
      return false;
    }
    
    // Additional checks
    if (email.length > 254) {
      return false; // RFC 5321 limit
    }
    
    // Check for common invalid patterns
    if (email.startsWith('.') || 
        email.endsWith('.') || 
        email.contains('..') ||
        email.contains('@.') ||
        email.contains('.@')) {
      return false;
    }
    
    return true;
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
        address: _addressController.text.trim(),
        city: _cityController.text.trim(),
        zipCode: _zipCodeController.text.trim(),
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
          'address': updatedUser.address ?? '',
          'city': updatedUser.city ?? '',
          'zipCode': updatedUser.zipCode ?? '',
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
                    return 'Please enter a valid email address ending with .com';
                  }
                  
                  // Check if email is already in use by another user
                  final newEmail = value.trim().toLowerCase();
                  final currentEmail = widget.user.email.toLowerCase();
                  
                  if (newEmail != currentEmail) {
                    // Only check if email is being changed
                    if (login_signup.users.containsKey(newEmail)) {
                      return 'This email is already in use by another account';
                    }
                  }
                  
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Phone Field
              const Text(
                'Phone Number',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Enter your phone number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.phone_outlined),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Address Field
              const Text(
                'Address',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  hintText: 'Enter your address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.home_outlined),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // City and ZIP Code Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'City',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _cityController,
                          decoration: InputDecoration(
                            hintText: 'Enter city',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter city';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ZIP Code',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _zipCodeController,
                          decoration: InputDecoration(
                            hintText: 'Enter ZIP code',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter ZIP code';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
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