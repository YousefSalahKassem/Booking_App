import 'package:bookingapp/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  _authenticate() => AuthCubit.get(context).authenticate();

  Widget _buildBodyContent() {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      if (state is AuthLoading) {
        debugPrint(state.runtimeType.toString());
        return const Center(child: CircularProgressIndicator());
      } else if (state is AuthError) {
        debugPrint(state.runtimeType.toString());
        return const Center(child: Text('ERROR', style: TextStyle(color: Colors.red)));
      } else if (state is AuthComplete) {
        debugPrint(state.runtimeType.toString());
        return Center(
            child: Text(
          'auth complete state type: ${state.auth.type}',
          style: const TextStyle(color: Colors.red),
        ));
      } else {
        return Center(
          child: ElevatedButton(
            onPressed: () => _authenticate(),
            child: const Text('LOGIN'),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Scaffold(appBar: AppBar(), body: _buildBodyContent()),
      onRefresh: () => _authenticate(),
    );
  }
}
