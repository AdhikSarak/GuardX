import 'dart:convert';
import 'package:http/http.dart' as http;

class EmailService {
  final String sendGridApiKey =
      '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';

  Future<void> sendEmail({
    required String toEmail,
    required String subject,
    required String body,
  }) async {
    final url = Uri.parse('https://api.sendgrid.com/v3/mail/send');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $sendGridApiKey',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'personalizations': [
          {
            'to': [
              {'email': toEmail}
            ],
            'subject': subject
          }
        ],
        'from': {'email': 'abhishek@crewhub.in'},
        'content': [
          {'type': 'text/plain', 'value': body}
        ]
      }),
    );

    if (response.statusCode == 202) {
      print('Email sent successfully');
    } else {
      print('Failed to send email: ${response.body}');
    }
  }
}
