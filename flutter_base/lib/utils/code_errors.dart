void methodErrorCast() {
  int inteiro = 0.0 as int; // Força um erro de tipo
  print(inteiro);
}

// Erro de divisão por zero
void methodDivideByZero() {
  int x = 10 ~/ 0;
  print(x);
}

// Erro de null
void methodNullError() {
  String? text;
  print(text!.length); // Força Null check error
}

// Erro de range
void methodRangeError() {
  var list = [1, 2, 3];
  print(list[99]); // Fora do range
}

// Erro de formato
void methodFormatError() {
  int.parse("not_a_number"); // Vai dar FormatException
}
