import 'package:bookingapp/src/core/shareable_components/my_button.dart';
import 'package:bookingapp/src/core/shareable_components/my_text_form_field.dart';
import 'package:bookingapp/src/core/utils/app_colors.dart';
import 'package:bookingapp/src/features/auth/data/models/login_model.dart';
import 'package:bookingapp/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookingapp/src/features/auth/presentation/widgets/auth_title_widget.dart';
import 'package:bookingapp/src/features/auth/presentation/widgets/hint_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void _logIn(LoginModel loginModel) => AuthCubit.get(context).logIn(loginModel);
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Widget _buildBodyContent() {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      if (state is LoginLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is AuthError) {
        return const Center(child: Text('ERROR', style: TextStyle(color: Colors.red)));
      } else if (state is LoginComplete) {
        return Center(child: Text('type:${state.status.type}'));
      } else {
        return Center(
          child: ElevatedButton(
            onPressed: () {
              _logIn(const LoginModel(
                email: 'abdullah.mansour@gmail.com',
                password: '123456',
              ));
            },
            child: const Text('LOGIN'),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AuthTitleWidget(text: 'Log in'),
              const SizedBox(height: 30),
              Row(
                children: [
                  _buildFacebookButton(),
                  const SizedBox(width: 15),
                  _buildTwitterButton(),
                ],
              ),
              const SizedBox(height: 15),
              const HintText(text: 'or log in with email'),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildEmailField(),
                    _buildPasswordField(),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              HintText(
                alignment: Alignment.centerRight,
                text: 'Forgot your password?',
                onTap: () {},
              ),
              const SizedBox(height: 15),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return MyButton(
                    text: 'Log in',
                    onPressed: () {
                      _logIn(LoginModel(
                        email: _emailController.text.isNotEmpty
                            ? _emailController.text
                            : 'abdullah.mansour@gmail.com',
                        password: _passwordController.text.isNotEmpty
                            ? _passwordController.text
                            : '123456',
                      ));
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  MyTextFormField _buildPasswordField() {
    return MyTextFormField(
      obscureText: true,
      labelText: 'Password',
      hintText: 'enter password',
      controller: _passwordController,
      inputAction: TextInputAction.done,
      inputType: TextInputType.visiblePassword,
    );
  }

  MyTextFormField _buildEmailField() {
    return MyTextFormField(
      labelText: 'Your email',
      hintText: 'enter your email',
      controller: _emailController,
      inputAction: TextInputAction.next,
      inputType: TextInputType.emailAddress,
    );
  }

  Expanded _buildTwitterButton() {
    return Expanded(
      child: MyButton(
        text: 'Twitter',
        onPressed: () {},
        icon: FontAwesomeIcons.twitter,
        backgroundColor: AppColors.twitterBlue,
      ),
    );
  }

  Expanded _buildFacebookButton() {
    return Expanded(
      child: MyButton(
        text: 'Facebook',
        onPressed: () {},
        icon: FontAwesomeIcons.facebookF,
        backgroundColor: AppColors.facebookBlue,
      ),
    );
  }
}
