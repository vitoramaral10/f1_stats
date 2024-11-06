enum UiError {
  unexpected,
}

extension UiErrorExtension on UiError {
  String get description {
    switch (this) {
      case UiError.unexpected:
        return 'Algo errado aconteceu. Tente novamente em breve.';
    }
  }
}
