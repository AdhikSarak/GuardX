import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guardx/consts/index.dart';

class GaurdXImp extends StatefulWidget {
  const GaurdXImp({super.key});

  @override
  _GaurtXImpState createState() => _GaurtXImpState();
}

class _GaurtXImpState extends State<GaurdXImp> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    const text =
        '''GuardX is a comprehensive security app designed to protect your digital life. It securely stores your passwords for various websites, ensuring you only need to remember one master password. In addition to password management, GuardX offers a secure space for storing important documents, keeping them safe from unauthorized access. It also protects your card information, ensuring that sensitive financial data is encrypted and stored securely. GuardX combines these essential features into one easy-to-use application, providing you with peace of mind and a convenient way to manage your digital security. With GuardX, you only need to remember one master password, which unlocks access to all your saved credentials. This feature not only reduces the likelihood of using weak or reused passwords—common vulnerabilities exploited by hackers—but also enhances your overall security.
          \n Additionally, GuardX can generate strong, unique passwords for your accounts and autofill them when needed, making your online interactions both safer and more convenient.''';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'GuardX Importance',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isExpanded ? text : text.substring(0, 800) + '...',
                textAlign: TextAlign.justify,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Text(
                  isExpanded ? 'Show Less' : 'Read More',
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
