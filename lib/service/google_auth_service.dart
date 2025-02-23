import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '461184437834-v2ubiidq1sirca0jhuiq74ton3ecaubn.apps.googleusercontent.com', // TODO add in config and explaing it in README
    scopes: ['email', 'openid', 'profile'],
  );

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print("Login annullato");
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final String idToken = googleAuth.idToken!;
      
      print("Google ID Token: $idToken");

      await authenticateWithCognito(idToken);
    } catch (error) {
      print("Errore durante il login con Google: $error");
    }
  }

  Future<void> authenticateWithCognito(String idToken) async {
    const String cognitoDomain = "https://flutter-google-login.auth.eu-central-1.amazoncognito.com"; // TODO add in config and explaing it in README
    const String clientId = "23vbq81qeo0iffds4ur4b0v9d4"; // TODO add in config and explaing it in README
    const String redirectUri = "myapp://callback"; // Es. myapp://callback

    final response = await http.post(
      Uri.parse("$cognitoDomain/oauth2/token"),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: {
        "grant_type": "authorization_code",
        "client_id": clientId,
        "code": idToken,
        "redirect_uri": redirectUri,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("Access Token Cognito: ${data['access_token']}");
    } else {
      print("Errore autenticazione Cognito: ${response.body}");
    }
  }
}
