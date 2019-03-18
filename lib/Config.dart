
class Configs {
  static const DOMAIN_API = "https://fighttechvn.github.io/api/data.json";
}

// ==================== Enum Type ====================
enum ScreenState { LOADING, ERROR, DONE }

class Dimension {
  static double height = 0.0;
  static double witdh = 0.0;

  static double getWidth(double size) {
    return witdh * size;
  }

  static double getHeight(double size) {
    return height * size;
  }
}