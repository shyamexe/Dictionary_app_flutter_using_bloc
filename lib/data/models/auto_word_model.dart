class AutoWordModel {
  String? word;
  int? score;

  AutoWordModel({this.word, this.score});

  AutoWordModel.fromJson(Map<String, dynamic> json) {
    word = json['word'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['word'] = this.word;
    data['score'] = this.score;
    return data;
  }

  @override
  String toString() => 'AutoWordModel(word: $word, score: $score)';
}
