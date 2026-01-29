class LevelCalculator {
  static const _levelNames = [
    '새싹 러너',
    '초보 러너',
    '러닝 입문자',
    '주니어 러너',
    '러너',
    '시니어 러너',
    '베테랑 러너',
    '엘리트 러너',
    '마스터 러너',
    '레전드 러너',
  ];

  static int getRequiredXp(int level) {
    if (level <= 1) return 0;
    if (level <= 5) return (level - 1) * 100;
    return 400 + (level - 5) * 500;
  }

  static int getLevelForXp(int xp) {
    int level = 1;
    while (getRequiredXp(level + 1) <= xp) {
      level++;
    }
    return level;
  }

  static String getLevelName(int level) {
    if (level <= 0) return _levelNames[0];
    if (level <= 10) return _levelNames[level - 1];
    final suffix = level - 9;
    return '레전드 러너 ${_toRoman(suffix)}';
  }

  static String _toRoman(int num) {
    const romans = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X'];
    return num <= 10 ? romans[num - 1] : num.toString();
  }
}
