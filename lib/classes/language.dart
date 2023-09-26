class Language {
  final int id;
  final String name;
  final String languageCode;

  Language(this.id, this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1,  "हिंदी", "hi"),
      Language(2,  "English", "en"),
      Language(3, "française", "fr"),
      Language(4, "Española", "es"),
      Language(5, "Português", "pt"),
      Language(6, "bahasa Indonesia", "id"),
      Language(7, "한국인", "ko"),
      Language(8, "日本語", "ja"),
      Language(9, "Русский", "ru"),
      Language(10, "ພາສາລາວ", "lo"),
    ];
  }
}
