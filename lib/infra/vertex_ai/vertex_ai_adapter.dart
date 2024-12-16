import 'dart:convert';
import 'dart:developer';

import 'package:firebase_vertexai/firebase_vertexai.dart';

import '../../data/vertex_ai/vertex_ai.dart';

class VertexAiAdapter implements VertexAiClient {
  @override
  Future<Map<String, dynamic>> run(String prompt,
      {Schema? responseSchema}) async {
    try {
      final model = FirebaseVertexAI.instance.generativeModel(
          model: 'gemini-1.5-flash',
          generationConfig: GenerationConfig(
            responseMimeType: 'application/json',
            responseSchema: responseSchema,
          ),
          safetySettings: [
            SafetySetting(
              HarmCategory.dangerousContent,
              HarmBlockThreshold.none,
            ),
     
          ]);

      final response = await model.generateContent([Content.text(prompt)]);

      if (response.text == null) {
        log('FirebaseError', name: 'FirebaseLoadDrivers.call.response.text');
        throw VertexAiError.unknown;
      }

      return jsonDecode(response.text!);
    } catch (error) {
      log(error.toString(), name: 'FirebaseLoadDrivers.call');
      throw VertexAiError.unknown;
    }
  }
}
