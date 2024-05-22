import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset('asset/05cItXL96l4LE9n02WfDR0h-5.webp',
        height: 150,  
        ),
        centerTitle: true,
      ),
    );
  }
}