class ApiConstants {
  const ApiConstants();

  static const String baseUrl = 'https://generativelanguage.googleapis.com';

  static const String interactionsPath = '/v1beta/interactions';

  static const String model = 'gemini-3-flash-preview';

  static const String apiKey = String.fromEnvironment('GEMINI_API_KEY');
}
