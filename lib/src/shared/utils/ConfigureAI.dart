import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ConfigureAI{
  late final GenerativeModel model;

  ConfigureAI(){
    model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: dotenv.env["GEMINI_KEY"].toString()
    );
  }
}