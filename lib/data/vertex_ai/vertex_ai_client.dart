import 'package:firebase_vertexai/firebase_vertexai.dart';

abstract class VertexAiClient {
  Future<Map<String, dynamic>> run(
    String prompt, {
    Schema? responseSchema,
  });
}
