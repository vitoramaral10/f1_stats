enum UiError {
  unexpected,
  notFound,
}

extension UiErrorExtension on UiError {
  String get description {
    switch (this) {
      case UiError.notFound:
        return 'Nenhum dado encontrado.';
      case UiError.unexpected:
        return 'Algo errado aconteceu. Tente novamente em breve.';
    }
  }
}
