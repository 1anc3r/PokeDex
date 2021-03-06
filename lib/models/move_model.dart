class MoveModel {
  String n; // 1
  String name; // 拍击
  String jname; // はたく
  String enname; // Pound
  String type; // 一般
  String damagecategory; // 物理

  int sourceType;
  String sourceText;

  String basepp; // 35
  String power; // 40
  String accuracy; // 100

  bool touches; // yes 是接触类招式
  bool protect; // yes 受守住影响
  bool magiccoat; // no 不受魔法反射影响
  bool snatch; // no 不可以被抢夺
  bool mirrormove; // yes 受鹦鹉学舌影响
  bool kingsrock; // yes 不受王者之证等类似道具影响

  MoveModel(this.sourceType, this.sourceText, this.name, this.type,
      this.damagecategory, this.power, this.accuracy, this.basepp) {
    sourceText = sourceText
        .replaceAll('招式学习器', '')
        .replaceAll('招式记录', '')
        .replaceAll('０', '0')
        .replaceAll('１', '1')
        .replaceAll('２', '2')
        .replaceAll('３', '3')
        .replaceAll('４', '4')
        .replaceAll('５', '5')
        .replaceAll('６', '6')
        .replaceAll('７', '7')
        .replaceAll('８', '8')
        .replaceAll('９', '9');
  }
}
