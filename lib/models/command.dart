class Command {
  String text;
  Who who;
  int? temp;
  Command({required this.text, required this.who,this.temp});
}

enum Who {
  user,
  bot,
}
