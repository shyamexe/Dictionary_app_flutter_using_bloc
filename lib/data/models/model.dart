class DictionaryModel {
  String? word;
  String? phonetic;
  List<Phonetics>? phonetics;
  String? origin;
  List<Meanings>? meanings;
  List<Definitions>? definitions;

  DictionaryModel(
      { this.word, this.phonetic, this.phonetics, this.origin, this.meanings,this.definitions});

  DictionaryModel.fromJson(Map<String, dynamic> json) {
    word = json['word']??"";
    phonetic = json['phonetic']??"";
    if (json['phonetics'] != null) {
      phonetics = <Phonetics>[];
      json['phonetics'].forEach((v) {
        phonetics!.add(Phonetics.fromJson(v));
      });
    }
    origin = json['origin']??"";
    if (json['meanings'] != null) {
      meanings = <Meanings>[];
      json['meanings'].forEach((v) {
        meanings!.add(Meanings.fromJson(v));
      });
    }
    if (json['definition'] != null) {
      definitions = <Definitions>[];
      json['definition'].forEach((v) {
        definitions!.add(Definitions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['word'] = word;
    data['phonetic'] = phonetic;
    if (phonetics != null) {
      data['phonetics'] = phonetics!.map((v) => v.toJson()).toList();
    }
    data['origin'] = origin;
    if (meanings != null) {
      data['meanings'] = meanings!.map((v) => v.toJson()).toList();
    }
    if (definitions != null) {
      data['definition'] = definitions!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  

  @override
  String toString() {
    return 'DictionaryModel(word: $word, phonetic: $phonetic, phonetics: $phonetics, origin: $origin, meanings: $meanings, definition: $definitions)';
  }
}

class Phonetics {
  String? text;
  String? audio;

  Phonetics({this.text, this.audio});

  Phonetics.fromJson(Map<String, dynamic> json) {
    text = json['text']??"";
    audio = json['audio']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['audio'] = audio;
    return data;
  }

  Phonetics copyWith({
    String? text,
    String? audio,
  }) {
    return Phonetics(
      text: text ?? this.text,
      audio: audio ?? this.audio,
    );
  }

  @override
  String toString() => 'Phonetics(text: $text, audio: $audio)';
}

class Meanings {
  String? partOfSpeech;
  List<Definitions>? definitions;

  Meanings({this.partOfSpeech, this.definitions});

  Meanings.fromJson(Map<String, dynamic> json) {
    partOfSpeech = json['partOfSpeech']??"";
    if (json['definitions'] != null) {
      definitions = <Definitions>[];
      json['definitions'].forEach((v) {
        definitions!.add(Definitions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['partOfSpeech'] = partOfSpeech;
    if (definitions != null) {
      data['definitions'] = definitions!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Meanings copyWith({
    String? partOfSpeech,
    List<Definitions>? definitions,
  }) {
    return Meanings(
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      definitions: definitions ?? this.definitions,
    );
  }

  @override
  String toString() => 'Meanings(partOfSpeech: $partOfSpeech, definitions: $definitions)';
}

class Definitions {
  String? definition;
  String? example;
  List<String>? synonyms;
  List<String>? antonyms;

  Definitions({this.definition, this.example, this.synonyms, this.antonyms});

  Definitions.fromJson(Map<String, dynamic> json) {
    definition = json['definition'];
    example = json['example'];
    synonyms = json['synonyms'] !=null?json['synonyms'].cast<String>():[""];
    antonyms = json['antonyms'] !=null?json['antonyms'].cast<String>():[""];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['definition'] = definition;
    data['example'] = example;
    data['synonyms'] = synonyms;
    data['antonyms'] = antonyms;
    return data;
  }

  @override
  String toString() {
    return 'Definitions(definition: $definition, example: $example, synonyms: $synonyms, antonyms: $antonyms)';
  }

  Definitions copyWith({
    String? definition,
    String? example,
    List<String>? synonyms,
    List<String>? antonyms,
  }) {
    return Definitions(
      definition: definition ?? this.definition,
      example: example ?? this.example,
      synonyms: synonyms ?? this.synonyms,
      antonyms: antonyms ?? this.antonyms,
    );
  }
}
