import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoozitest/base/utils/colors.dart';
import 'package:zoozitest/base/widgets/app_button.dart';
import 'package:zoozitest/base/widgets/decorations.dart/form_decorations.dart';
import 'package:zoozitest/l10n/app_localizations.dart';
import 'package:zoozitest/models/requests/auth_request.dart';
import 'package:zoozitest/repositories/auth_repository.dart';

@RoutePage()
class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;

  _onSubmit() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;
      final email = values['email'];
      final password = values['password'];
      final name = values['name'];

      setState(() {
        _isLoading = true;
      });

      try {
        final authRepository = ref.read(authRepositoryProvider);
        await authRepository.register(
          AuthRequest(email: email, password: password, name: name),
        );
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.userRegisteredSuccess),
            duration: const Duration(seconds: 3),
          ),
        );
        context.router.back();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            duration: const Duration(seconds: 3),
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final formDecoration = FormDecorations.defaultDecoration(context: context);
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.register)),
      body: PopScope(
        canPop: !_isLoading,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.background(context),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: FormBuilder(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context)!.email),
                          const SizedBox(height: 8),
                          FormBuilderTextField(
                            name: 'email',
                            decoration: formDecoration.copyWith(
                              prefixIcon: const Icon(Icons.email_outlined),
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: AppLocalizations.of(
                                  context,
                                )!.emailRequired,
                              ),
                              FormBuilderValidators.email(),
                            ]),
                          ),
                          const SizedBox(height: 16),
                          Text(AppLocalizations.of(context)!.password),
                          const SizedBox(height: 8),
                          FormBuilderTextField(
                            name: 'password',
                            obscureText: true,
                            decoration: formDecoration.copyWith(
                              prefixIcon: const Icon(Icons.lock_outline),
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: AppLocalizations.of(
                                  context,
                                )!.passwordRequired,
                              ),
                              FormBuilderValidators.minLength(
                                8,
                                errorText: AppLocalizations.of(
                                  context,
                                )!.passwordMinLength,
                              ),
                            ]),
                          ),
                          const SizedBox(height: 16),
                          Text(AppLocalizations.of(context)!.nameOptional),
                          const SizedBox(height: 8),
                          FormBuilderTextField(
                            name: 'name',
                            decoration: formDecoration.copyWith(
                              prefixIcon: const Icon(Icons.person_outline),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                    onPressed: _onSubmit,
                    text: AppLocalizations.of(context)!.register,
                    isLoading: _isLoading,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
