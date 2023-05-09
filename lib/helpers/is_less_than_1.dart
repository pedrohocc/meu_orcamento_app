bool isLessThan1(String? value) {
  final double valor = double.parse(value!);
  late bool result;

  valor < 1 ? result = true : result = false;

  return result;
}
