// import 'package:commerce_flutter_app/features/presentation/cubit/biometric/biometric_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:local_auth/local_auth.dart';

// class BiometricLoginScreen extends StatelessWidget {
//   const BiometricLoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => BiometricCubit()..loadBiometric(),
//       child: const BiometricLoginPage(),
//     );
//   }
// }

// class BiometricLoginPage extends StatelessWidget {
//   const BiometricLoginPage({super.key});

//   Future<bool> _authenticateWithBiometrics() async {
//     final LocalAuthentication auth = LocalAuthentication();
//     try {
//       final bool authenticated = await auth.authenticate(
//         localizedReason: 'Authenticate for biometric login',
//         options: const AuthenticationOptions(
//           biometricOnly: true,
//           stickyAuth: true,
//         ),
//       );

//       return authenticated;
//     } on PlatformException catch (e) {
//       print(e);
//       return false;
//     }
//   }

//   Future<void> _authenticationHelper(context) async {
//     bool isAuthenticated = await _authenticateWithBiometrics();
//     if (isAuthenticated) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//         'Authenticated',
//         style: TextStyle(color: Colors.white),
//       )));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//         'Failed to authenticate',
//         style: TextStyle(color: Colors.red),
//       )));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ElevatedButton(
//             onPressed: () {
//               _authenticationHelper(context);
//             },
//             child: BlocBuilder<BiometricCubit, BiometricState>(
//               builder: (context, state) {
//                 if (state is BiometricEnabledFace) {
//                   return const Text('Face ID');
//                 } else if (state is BiometricEnabledTouch) {
//                   return const Text('Touch ID');
//                 } else if (state is BiometricDisabled) {
//                   return const Text('Biometric is disabled');
//                 }
//                 return const Text('...');
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
