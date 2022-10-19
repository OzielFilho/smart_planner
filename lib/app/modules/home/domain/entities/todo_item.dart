class TodoItem {
  final String title;
  final String description;
  final String group;
  final int progress;
  final DateTime createAt;

  TodoItem(
      {required this.title,
      required this.description,
      required this.group,
      required this.progress,
      required this.createAt});
}
