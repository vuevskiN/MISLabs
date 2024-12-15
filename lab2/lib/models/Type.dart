class Type {
  final String punchline;
  final String setup;

  Type({
    required this.punchline,
    required this.setup,
  });

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      punchline: json['punchline'],
      setup: json['setup'],
    );
  }
}
