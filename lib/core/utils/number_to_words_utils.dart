import 'package:intl/intl.dart';

String convertNumberToIndianWords(double amount) {
  if (amount == 0) return 'Rupees Zero Only';
  final int absoluteAmount = amount.truncate();
  final int paisa = ((amount - absoluteAmount) * 100).round();
  String rupeePart = _convertToIndianWords(absoluteAmount);
  String paisaPart = '';
  if (paisa > 0) {
    paisaPart = ' and ${_convertToIndianWords(paisa)} Paisa';
  }
  String result = 'Rupees $rupeePart$paisaPart Only';
  return result.replaceAll(RegExp(r'\s+'), ' ');
}

String _convertToIndianWords(int number) {
  if (number == 0) return '';
  const Map<int, String> unitsMap = {
    0: '', 1: 'One', 2: 'Two', 3: 'Three', 4: 'Four', 5: 'Five', 6: 'Six', 7: 'Seven',
    8: 'Eight', 9: 'Nine', 10: 'Ten', 11: 'Eleven', 12: 'Twelve', 13: 'Thirteen',
    14: 'Fourteen', 15: 'Fifteen', 16: 'Sixteen', 17: 'Seventeen', 18: 'Eighteen', 19: 'Nineteen'
  };
  const Map<int, String> tensMap = {
    0: '', 1: 'Ten', 2: 'Twenty', 3: 'Thirty', 4: 'Forty', 5: 'Fifty', 6: 'Sixty',
    7: 'Seventy', 8: 'Eighty', 9: 'Ninety'
  };
  if (number < 20) return unitsMap[number]!;
  if (number < 100) {
    final int tens = number ~/ 10;
    final int units = number % 10;
    return '${tensMap[tens]}${units > 0 ? '-${unitsMap[units]}' : ''}';
  }
  if (number < 1000) {
    final int hundreds = number ~/ 100;
    final int remaining = number % 100;
    final String remString = remaining > 0 ? ' ${_convertToIndianWords(remaining)}' : '';
    return '${unitsMap[hundreds]} Hundred$remString';
  }
  if (number < 100000) {
    final int thousands = number ~/ 1000;
    final int remaining = number % 1000;
    final String remString = remaining > 0 ? ' ${_convertToIndianWords(remaining)}' : '';
    return '${_convertToIndianWords(thousands)} Thousand$remString';
  }
  if (number < 10000000) {
    final int lakhs = number ~/ 100000;
    final int remaining = number % 100000;
    final String remString = remaining > 0 ? ' ${_convertToIndianWords(remaining)}' : '';
    return '${_convertToIndianWords(lakhs)} Lakh$remString';
  }
  final int crores = number ~/ 10000000;
  final int remaining = number % 10000000;
  final String remString = remaining > 0 ? ' ${_convertToIndianWords(remaining)}' : '';
  return '${_convertToIndianWords(crores)} Crore$remString';
}
