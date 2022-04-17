class Money {
  final Currency currency;
  final double amount;

  const Money(this.amount, {this.currency = Currency.TRY});
}

enum Currency {
  USD,
  TRY,
  EUR
}

