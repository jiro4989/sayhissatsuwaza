type
  ElementType* {.pure.} = enum
    ## 要素。炎とか氷とか。
    non, fire, ice, wind, thunder, holy, darkness

  AttackType* {.pure.} = enum
    ## 攻撃の種類。斬撃、打撃、刺突。
    slash, blow, thrust

  VerbType* {.pure.} = enum
    ## 動詞の種類。
    common

  NounType* {.pure.} = enum
    ## 名詞の種類。
    common

  Kind* {.pure.} = enum
    ## 属性の種類。
    element,
    attack,
    verb, # 動詞
    noun  # 名詞

  Attribute* = object
    ## ElementとAttackをラップして1つの型にラッピングしたもの。
    ## Generatorで1つの型として扱うために存在する。
    case kind*: Kind
    of element:
      fElement*: ElementType
    of attack:
      fAttack*: AttackType
    of verb:
      fVerb*: VerbType
    of noun:
      fNoun*: NounType

  Syllabary* {.pure.} = enum
    ## 音節。Language = jaの時だけ使用する。
    kanji, katakana

  Generator* = object
    ## 必殺技名の組み合わせを定義したジェネレーター。
    ## 命名ルールと言語。
    lang*: Language
    syllabary*: Syllabary ## lang = ja の時だけ使用する。
    pattern*: seq[Attribute]

  Language* = enum
    ja = "ja_JP"
    en = "en_US"
    zhCN = "zh_CN"
    zhTW = "zh_TW"

const
  # Element
  attrNon* = Attribute(kind: element, fElement: non)
  attrFire* = Attribute(kind: element, fElement: fire)
  attrIce* = Attribute(kind: element, fElement: ice)
  attrWind* = Attribute(kind: element, fElement: wind)
  attrThunder* = Attribute(kind: element, fElement: thunder)
  attrHoly* = Attribute(kind: element, fElement: holy)
  attrDarkness* = Attribute(kind: element, fElement: darkness)

  # Attack
  attrSlash* = Attribute(kind: attack, fAttack: slash)
  attrBlow* = Attribute(kind: attack, fAttack: blow)
  attrThrust* = Attribute(kind: attack, fAttack: thrust)

  # Verb
  attrVerbCommon* = Attribute(kind: verb, fVerb: VerbType.common)

  # Noun
  attrNounCommon* = Attribute(kind: noun, fNoun: NounType.common)
