import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../../providers/auth_provider.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _ageController;
  String? _selectedLanguage;
  XFile? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  final List<String> _languages = [
    'Español',
    'English',
    'Français',
    'Deutsch',
    'Italiano',
    'Português',
  ];

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthProvider>().user;
    _nameController = TextEditingController(text: user?.name);
    _emailController = TextEditingController(text: user?.email);
    _ageController = TextEditingController(text: user?.age?.toString() ?? '');
    _selectedLanguage = user?.language ?? 'Español';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (image != null) {
      setState(() {
        _pickedImage = image;
      });
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AuthProvider>();
    final currentUser = authProvider.user;

    if (currentUser == null) return;

    final updatedUser = currentUser.copyWith(
      name: _nameController.text,
      email: _emailController.text,
      age: int.tryParse(_ageController.text),
      language: _selectedLanguage,
      profileImageUrl: _pickedImage?.path,
    );

    final success = await authProvider.updateUser(updatedUser);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success ? 'Perfil actualizado' : 'Error al actualizar perfil',
          ),
          backgroundColor: success ? Colors.green : Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Editar perfil',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.titleMedium?.color,
                  ),
                ),
                if (authProvider.isLoading)
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                else
                  TextButton(
                    onPressed: _saveProfile,
                    child: const Text(
                      'Guardar',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 24),

            // Sección del Avatar: Permite ver y cambiar la foto de perfil del usuario
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                            image: (_pickedImage != null)
                                ? DecorationImage(
                                    image: FileImage(File(_pickedImage!.path)),
                                    fit: BoxFit.cover,
                                  )
                                : (authProvider.user?.profileImageUrl != null)
                                ? DecorationImage(
                                    image: NetworkImage(
                                      authProvider.user!.profileImageUrl!,
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child:
                              (_pickedImage == null &&
                                  authProvider.user?.profileImageUrl == null)
                              ? Center(
                                  child: Text(
                                    _nameController.text.isNotEmpty
                                        ? _nameController.text[0].toUpperCase()
                                        : '?',
                                    style: TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onPrimaryContainer,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              size: 18,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Haz clic en la cámara para cambiar la foto',
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(
                        context,
                      ).textTheme.bodySmall?.color?.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Formulario de Datos: Campos editables de información personal
            _buildTextField(
              label: 'Nombre',
              icon: Icons.person_outline,
              controller: _nameController,
              description:
                  'Este nombre aparecerá cuando te mencionen en los chats',
              validator: (v) => v!.isEmpty ? 'El nombre es obligatorio' : null,
            ),

            _buildDropdownField(
              label: 'Idioma principal',
              icon: Icons.translate,
              value: _selectedLanguage!,
              description:
                  'Los mensajes se traducirán a este idioma automáticamente',
              onChanged: (v) => setState(() => _selectedLanguage = v),
            ),

            _buildTextField(
              label: 'Correo electrónico',
              icon: Icons.email_outlined,
              controller: _emailController,
              description:
                  'Este correo electrónico se utilizará para comunicaciones importantes',
              validator: (v) {
                if (v!.isEmpty) return 'El correo es obligatorio';
                if (!v.contains('@')) return 'Correo inválido';
                return null;
              },
            ),

            _buildTextField(
              label: 'Edad',
              icon: Icons.calendar_today_outlined,
              controller: _ageController,
              keyboardType: TextInputType.number,
              description:
                  'Esta información es opcional y se utilizará para personalizar tu experiencia',
            ),

            _buildReadOnlyField(
              label: 'Número de teléfono',
              icon: Icons.phone_outlined,
              value: authProvider.user?.phoneNumber ?? 'N/A',
              description: 'El número de teléfono no se puede modificar',
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required String description,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: Theme.of(
                  context,
                ).textTheme.bodySmall?.color?.withOpacity(0.7),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            style: const TextStyle(fontSize: 15),
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest.withOpacity(0.1),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Theme.of(context).dividerColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Theme.of(context).dividerColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.blueAccent),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: TextStyle(
              color: Theme.of(
                context,
              ).textTheme.bodySmall?.color?.withOpacity(0.5),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required IconData icon,
    required String value,
    required String description,
    required void Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: Theme.of(
                  context,
                ).textTheme.bodySmall?.color?.withOpacity(0.7),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surfaceVariant.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Theme.of(context).dividerColor),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                dropdownColor: Theme.of(context).colorScheme.surface,
                icon: const Icon(Icons.keyboard_arrow_down),
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontSize: 15,
                ),
                onChanged: onChanged,
                items: _languages.map((String lang) {
                  return DropdownMenuItem<String>(
                    value: lang,
                    child: Text(lang),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: TextStyle(
              color: Theme.of(
                context,
              ).textTheme.bodySmall?.color?.withOpacity(0.5),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReadOnlyField({
    required String label,
    required IconData icon,
    required String value,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: Theme.of(
                  context,
                ).textTheme.bodySmall?.color?.withOpacity(0.7),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).disabledColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Theme.of(context).dividerColor),
            ),
            child: Text(
              value,
              style: TextStyle(
                color: Theme.of(context).disabledColor,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: TextStyle(
              color: Theme.of(
                context,
              ).textTheme.bodySmall?.color?.withOpacity(0.5),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
