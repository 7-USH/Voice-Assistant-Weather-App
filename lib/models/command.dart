class Command {
  String text;
  Who who;
  Command({required this.text,required this.who});
}

enum Who {
  user,
  bot,
}
