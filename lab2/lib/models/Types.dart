class Types {
  final String type;

  Types({required this.type});

  factory Types.fromJson(String json) {
    return Types(type: json);
  }
}