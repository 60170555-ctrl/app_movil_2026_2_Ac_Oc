class AppConfig {
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://dummyjson.com',
  );
  
  // Cámbialo a 1 si quieres probar la renovación automática rápido
  static const int accessTokenMinutes = 30; 
}
