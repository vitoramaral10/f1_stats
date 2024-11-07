enum UiError {
  unexpected,
  notFound,
  tooManyRequests,
}

extension UiErrorExtension on UiError {
  String get description {
    switch (this) {
      case UiError.tooManyRequests:
        return 'Muitas requisições. Tente novamente em breve.';
      case UiError.notFound:
        return 'Nenhum dado encontrado.';
      case UiError.unexpected:
        return 'Algo errado aconteceu. Tente novamente em breve.';
    }
  }
}
