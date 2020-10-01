class CalcUtil {
  static int CalcPower(
      int type,
      int speciesStrength, // 种族值
      int individualValue, // 个体值
      int basePoint, // 基础点数
      int level, // 等级
      double nature // 性格
      ) {
    if (type == 0) {
      return ((speciesStrength * 2 + individualValue + basePoint / 4) *
                  level /
                  100 +
              10 +
              level)
          .toInt();
    } else {
      return (((speciesStrength * 2 + individualValue + basePoint / 4) *
                      level /
                      100 +
                  5) *
              nature)
          .toInt();
    }
  }
}
