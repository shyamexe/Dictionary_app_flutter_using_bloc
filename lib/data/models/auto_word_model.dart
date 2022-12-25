class AutoWordModel {
  String? word;
  int? score;

  AutoWordModel({this.word, this.score});

  AutoWordModel.fromJson(Map<String, dynamic> json) {
    word = json['word'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['word'] = word;
    data['score'] = score;
    return data;
  }

  @override
  String toString() => 'AutoWordModel(word: $word, score: $score)';
}
