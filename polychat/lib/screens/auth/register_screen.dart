import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController =
      TextEditingController(); // Added for completeness
  String _selectedLanguage = 'es Español';

  final List<String> _languages = [
    'es Español',
    'en English',
    'fr Français',
    'de Deutsch',
  ];

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Las contraseñas no coinciden')),
          );
        }
        return;
      }

      final success = await context.read<AuthProvider>().register(
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
        lastName: _lastNameController.text,
        phoneNumber: _phoneController.text,
        age: int.tryParse(_ageController.text),
        language: _selectedLanguage,
      );
      if (success) {
        if (mounted) context.go('/verify');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                // Logo central de la aplicación
                Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.chat_bubble_outline,
                      size: 35,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Título principal
                Text(
                  'PolyChat',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.titleLarge?.color,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                // Selector de Pestañas: Alternar entre Iniciar Sesión y Registro
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => context.go('/login'),
                          child: Text(
                            'Iniciar Sesión',
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).textTheme.bodySmall?.color,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryContainer.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Registrarse',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // Formulario de Registro: Campos de datos personales del usuario
                // Nombre y Apellidos
                Row(
                  children: [
                    Expanded(
                      child: _buildFieldLabel(Icons.person_outline, 'Nombre'),
                    ),
                    const SizedBox(width: 16),
                    Expanded(child: _buildFieldLabel(null, 'Apellidos')),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: _buildTextField(_nameController, 'Juan')),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(_lastNameController, 'Pérez'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Campo de Correo Electrónico
                _buildFieldLabel(Icons.email_outlined, 'Correo electrónico'),
                const SizedBox(height: 8),
                _buildTextField(_emailController, 'juan.perez@ejemplo.com'),
                const SizedBox(height: 16),
                // Campo de Teléfono
                _buildFieldLabel(Icons.phone_outlined, 'Número de teléfono'),
                const SizedBox(height: 8),
                _buildTextField(_phoneController, '123 456 7890'),
                const SizedBox(height: 16),
                // Sección de Seguridad: Contraseña y Confirmación
                _buildFieldLabel(Icons.lock_outline, 'Contraseña'),
                const SizedBox(height: 8),
                _buildTextField(
                  _passwordController,
                  '••••••••',
                  isPassword: true,
                ),
                const SizedBox(height: 16),
                _buildFieldLabel(null, 'Confirmar contraseña'),
                const SizedBox(height: 8),
                _buildTextField(
                  _confirmPasswordController,
                  '••••••••',
                  isPassword: true,
                ),
                const SizedBox(height: 16),
                // Preferencias Adicionales: Edad e Idioma preferido
                Row(
                  children: [
                    Expanded(
                      child: _buildFieldLabel(
                        Icons.calendar_today_outlined,
                        'Edad',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildFieldLabel(
                        Icons.translate_outlined,
                        'Idioma',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        _ageController,
                        '18',
                        isNumber: true,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(child: _buildDropdownField()),
                  ],
                ),
                const SizedBox(height: 32),
                // Botón de Finalización: Crear la cuenta nueva
                if (authProvider.isLoading)
                  Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                else
                  ElevatedButton(
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Crear cuenta',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(IconData? icon, String label) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
            size: 16,
          ),
          const SizedBox(width: 8),
        ],
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodySmall?.color,
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    bool isNumber = false,
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: isNumber
          ? TextInputType.number
          : (isPassword ? TextInputType.text : TextInputType.emailAddress),
      style: TextStyle(
        color: Theme.of(context).textTheme.bodyLarge?.color,
        fontSize: 15,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Theme.of(context).hintColor.withOpacity(0.3),
        ),
        filled: true,
        fillColor: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withOpacity(0.1),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).dividerColor.withOpacity(0.1),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
          ),
        ),
        errorStyle: const TextStyle(height: 0),
      ),
      validator: (value) => value!.isEmpty ? '' : null,
    );
  }

  Widget _buildDropdownField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 54, // Match height of text fields
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.1),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedLanguage,
          dropdownColor: Theme.of(context).colorScheme.surface,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
            size: 20,
          ),
          isExpanded: true,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontSize: 15,
          ),
          items: _languages.map((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _selectedLanguage = newValue!;
            });
          },
        ),
      ),
    );
  }
}
