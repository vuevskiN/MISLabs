class Random {
  final String punchline;
  final String setup;

  Random({
    required this.punchline,
    required this.setup,
  });

  factory Random.fromJson(Map<String, dynamic> json) {
    return Random(
      punchline: json['punchline'],
      setup: json['setup'],
    );
  }
}
