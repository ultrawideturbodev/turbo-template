class ExtraArguments {
  ExtraArguments({
    this.id,
  });

  final String? id;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

  factory ExtraArguments.fromMap(Map<String, dynamic> map) {
    return ExtraArguments(
      id: map['id'] as String?,
    );
  }
}
