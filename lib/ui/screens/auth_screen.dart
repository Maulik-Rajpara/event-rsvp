import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/auth_provider.dart';
import 'event_list_screen.dart';

class AuthScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.read(authProvider);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final user = await authService.signInWithGoogle();
            if (user != null) {
              Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => EventListScreen()),
              );
            }
          },
          child: Text("Sign in with Google"),
        ),
      ),
    );
  }
}
