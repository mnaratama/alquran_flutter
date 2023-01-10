// API URL : https://api.quran.gading.dev/juz/1
// Get all ayat per juz dalam Al-Quran

import 'dart:convert';

Juz juzFromJson(String str) => Juz.fromJson(json.decode(str));

String juzToJson(Juz data) => json.encode(data.toJson());

class Juz {
  int? juz;
  String? juzStartInfo;
  String? juzEndInfo;
  int? totalVerses;
  List<Verses>? verses;

  Juz(
      {this.juz,
        this.juzStartInfo,
        this.juzEndInfo,
        this.totalVerses,
        this.verses});

  factory Juz.fromJson(Map<String, dynamic>? json) => Juz(
    juz: json?["juz"],
    juzStartInfo: json?["juzStartInfo"],
    juzEndInfo: json?["juzEndInfo"],
    totalVerses: json?["totalVerses"],
    verses: List<Verses>.from(json!["verses"].map((x) => Verses.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "juz": juz,
    "juzStartInfo": juzStartInfo,
    "juzEndInfo": juzEndInfo,
    "totalVerses": totalVerses,
    "verses": verses == null
        ? null : List<dynamic>.from(verses!.map((x) => x.toJson())),
  };
}

class Verses {
  Verses({
    this.number,
    this.meta,
    this.text,
    this.translation,
    this.audio,
    this.tafsir,
    this.kondisiAudio = "stop"
  });

  Number? number;
  Meta? meta;
  Text? text;
  Translation? translation;
  Audio? audio;
  Tafsir? tafsir;
  String kondisiAudio;

  factory Verses.fromJson(Map<String, dynamic>? json) => Verses(
    number: Number.fromJson(json?["number"]),
    meta: Meta.fromJson(json?["meta"]),
    text: Text.fromJson(json?["text"]),
    translation: Translation.fromJson(json?["translation"]),
    audio: Audio.fromJson(json?["audio"]),
    tafsir: Tafsir.fromJson(json?["tafsir"]),
  );

  Map<String, dynamic> toJson() => {
    "number": number?.toJson(),
    "meta": meta?.toJson(),
    "text": text?.toJson(),
    "translation": translation?.toJson(),
    "audio": audio?.toJson(),
    "tafsir": tafsir?.toJson(),
    "kondisiAudio": kondisiAudio,
  };
}

class Number {
  int? inQuran;
  int? inSurah;

  Number({this.inQuran, this.inSurah});

  Number.fromJson(Map<String, dynamic> json) {
    inQuran = json['inQuran'];
    inSurah = json['inSurah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inQuran'] = this.inQuran;
    data['inSurah'] = this.inSurah;
    return data;
  }
}

class Meta {
  int? juz;
  int? page;
  int? manzil;
  int? ruku;
  int? hizbQuarter;
  Sajda? sajda;

  Meta(
      {this.juz,
        this.page,
        this.manzil,
        this.ruku,
        this.hizbQuarter,
        this.sajda});

  Meta.fromJson(Map<String, dynamic> json) {
    juz = json['juz'];
    page = json['page'];
    manzil = json['manzil'];
    ruku = json['ruku'];
    hizbQuarter = json['hizbQuarter'];
    sajda = json['sajda'] != null ? new Sajda.fromJson(json['sajda']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['juz'] = this.juz;
    data['page'] = this.page;
    data['manzil'] = this.manzil;
    data['ruku'] = this.ruku;
    data['hizbQuarter'] = this.hizbQuarter;
    if (this.sajda != null) {
      data['sajda'] = this.sajda!.toJson();
    }
    return data;
  }
}

class Sajda {
  bool? recommended;
  bool? obligatory;

  Sajda({this.recommended, this.obligatory});

  Sajda.fromJson(Map<String, dynamic> json) {
    recommended = json['recommended'];
    obligatory = json['obligatory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recommended'] = this.recommended;
    data['obligatory'] = this.obligatory;
    return data;
  }
}

class Text {
  String? arab;
  Transliteration? transliteration;

  Text({this.arab, this.transliteration});

  Text.fromJson(Map<String, dynamic> json) {
    arab = json['arab'];
    transliteration = json['transliteration'] != null
        ? new Transliteration.fromJson(json['transliteration'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['arab'] = this.arab;
    if (this.transliteration != null) {
      data['transliteration'] = this.transliteration!.toJson();
    }
    return data;
  }
}

class Transliteration {
  String? en;

  Transliteration({this.en});

  Transliteration.fromJson(Map<String, dynamic> json) {
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    return data;
  }
}

class Translation {
  String? en;
  String? id;

  Translation({this.en, this.id});

  Translation.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['id'] = this.id;
    return data;
  }
}

class Audio {
  String? primary;
  List<String>? secondary;

  Audio({this.primary, this.secondary});

  Audio.fromJson(Map<String, dynamic> json) {
    primary = json['primary'];
    secondary = json['secondary'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['primary'] = this.primary;
    data['secondary'] = this.secondary;
    return data;
  }
}

class Tafsir {
  Id? id;

  Tafsir({this.id});

  Tafsir.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? new Id.fromJson(json['id']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) {
      data['id'] = this.id!.toJson();
    }
    return data;
  }
}

class Id {
  String? short;
  String? long;

  Id({this.short, this.long});

  Id.fromJson(Map<String, dynamic> json) {
    short = json['short'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['short'] = this.short;
    data['long'] = this.long;
    return data;
  }
}