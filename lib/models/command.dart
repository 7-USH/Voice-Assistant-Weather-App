class Command {
  String text;
  Who who;
  int? temp;
  int? id;
  Command({required this.text, required this.who, this.temp,this.id});
}

enum Who {
  user,
  bot,
}
