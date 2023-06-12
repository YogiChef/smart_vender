import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_vendor/vendors/landing.dart';

class VendorAuthPage extends StatelessWidget {
  const VendorAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return SignInScreen(providers: [
            EmailAuthProvider(),
           
          ]);
        }
        return LandingPage();
      }
      );
  }
}

// StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       initialData: FirebaseAuth.instance.currentUser,
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const SignInScreen(providerConfigs: [
//             EmailProviderConfiguration(),
//             GoogleProviderConfiguration(
//                 clientId: '1:279393469363:android:31c4a5f34b450d776381c6'),
//             PhoneProviderConfiguration(),
//           ]);
//         }
//         return const MainVendorPage();
//       },
//     );
