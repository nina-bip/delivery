String formatDa(int amount) => '$amount DA';

bool isAlgerianPhone(String raw) {
  final digits = raw.replaceAll(RegExp(r'[\s-]'), '');
  return RegExp(r'^(0|\+213)(5|6|7)\d{8}$').hasMatch(digits);
}
