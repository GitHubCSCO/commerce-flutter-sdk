import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConnectStorePage extends StatelessWidget {
  const ConnectStorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                child: Image.asset(
                  'assets/images/optimizely-logo.png',
                  width: 100,
                  height: 100,
                ),
              ),
              SizedBox(
                width: 350,
                height: 250,
                child: Card(
                  elevation: 5,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Connect Store',
                          style: GoogleFonts.roboto(
                            textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: 28,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const TextField(
                          decoration: InputDecoration(
                            alignLabelWithHint: false,
                            labelText: 'Enter Store URL',
                            hintText: 'Example store.optimizely.com',
                            border: OutlineInputBorder(),
                          ),
                          // controller: usernameController,
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () {},
                            child: Container(
                              padding: const EdgeInsets.all(1),
                              child: const Text('Continue'),
                            ),
                          ),
                        )
                      ],
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
