enum UiError {
  unexpected,
}

extension UiErrorExtension on UiError {
  String get description {
    switch (this) {
      case UiError.unexpected:
        return 'An unexpected error has occurred. Please try again later.';
    }
  }
}
