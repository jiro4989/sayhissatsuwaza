type
  Language* {.pure.} = enum
    ja = "ja_JP"
    en = "en_US"
    zhCN = "zh_CN"
    zhTW = "zh_TW"

  Attribute* = enum
    kanji, katakana,
    element, non, fire, ice, wind, thunder, holy, darkness,
    attack, slash, blow, thrust,
    assist

  PartOfSpeech* {.pure.} = enum
    ## 品詞。
    verb, # 動詞
    noun  # 名詞

  Word* = object
    partOfSpeech*: PartOfSpeech
    attrs*: seq[Attribute]
    text*: string

  SearchCondition* = object
    partOfSpeech*: PartOfSpeech
    attrs*: seq[Attribute]
