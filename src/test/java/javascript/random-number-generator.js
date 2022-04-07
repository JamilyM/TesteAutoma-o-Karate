function randomNumberGenerator(length) {
  var randomNumber;

  // Garante que o primeiro dígito seja diferente de zero
  var num = Math.floor(Math.random() * 8 + 1);
  randomNumber = num.toString();

  // Continua preenchendo o número até que tenha o número correto de dígitos no total e converte para string
  while (randomNumber.length < length) {
    num = Math.floor(Math.random() * 9);
    randomNumber += num.toString();
  }

  return randomNumber;
}
