import tables, random

type
  ElementType {.pure.} = enum
    non, fire, ice, wind, thunder, holy, darkness

  AttackType {.pure.} = enum
    slash, blow, thrust

  Kind {.pure.} = enum
    element, attack

  Attribute = object
    case kind: Kind
    of element:
      fElement: ElementType
    of attack:
      fAttack: AttackType

  Language {.pure.} = enum
    ja, en

  Generator = object
    lang: Language
    pattern: seq[Attribute]

const
  # Element
  attrNon = Attribute(kind: element, fElement: non)
  attrFire = Attribute(kind: element, fElement: fire)
  attrIce = Attribute(kind: element, fElement: ice)
  attrWind = Attribute(kind: element, fElement: wind)
  attrThunder = Attribute(kind: element, fElement: thunder)
  attrHoly = Attribute(kind: element, fElement: holy)
  attrDarkness = Attribute(kind: element, fElement: darkness)

  # Attack
  attrSlash = Attribute(kind: attack, fAttack: slash)
  attrBlow = Attribute(kind: attack, fAttack: blow)
  attrThrust = Attribute(kind: attack, fAttack: thrust)

  generators = @[
    Generator(lang: ja, pattern: @[attrFire, attrSlash]),
    Generator(lang: en, pattern: @[attrFire, attrSlash]),
    Generator(lang: ja, pattern: @[attrWind, attrThunder, attrBlow]),
    Generator(lang: en, pattern: @[attrHoly, attrThrust]),
    Generator(lang: en, pattern: @[attrNon, attrBlow]),
    Generator(lang: en, pattern: @[attrIce, attrWind]),
  ]

  elementWords = {
    ja: {
      non: @["強", "業"],
      fire: @["火炎", "紅蓮", "炎", "爆", "爆炎", "爆裂", "炎帝"],
      ice: @["氷結", "氷"],
      wind: @["風神", "疾風", "旋風"],
      thunder: @["雷", "雷神", "稲妻", "雷光"],
      holy: @["聖", "光"],
      darkness: @["闇", "暗黒"],
    }.toTable,
    en: {
      non: @["ブレイブ", "エクスプロージョン", "ファイナル"],
      fire: @["ファイア", "フレイム"],
      ice: @["アイス", "アイシクル", "フリーズ"],
      wind: @["ウィンド", "ストーム"],
      thunder: @["サンダー", "プラズマ"],
      holy: @["セイント", "ホーリー", "ライト"],
      darkness: @["ダーク", "ダークネス"],
    }.toTable,
  }.toTable

  attackWords = {
    ja: {
      slash: @["斬", "剣", "刃"],
      blow: @["撃", "掌"],
      thrust: @["突"],
    }.toTable,
    en: {
      slash: @["スラッシュ", "ブレード", "ソード"],
      blow: @["ブロウ", "クラッシュ", "アタック", "ブレイク"],
      thrust: @["スラスト", "ピアース"],
    }.toTable,
  }.toTable

func isElement(pat: Attribute): bool =
  pat.kind == element

func isAttack(pat: Attribute): bool =
  pat.kind == attack

proc generate*(): string =
  ## 関数内では乱数初期化をしないので、呼び出し側で制御すること。
  let gen = generators.sample
  for attr in gen.pattern:
    if attr.isElement:
      let elem = attr.fElement
      let v = elementWords[gen.lang][elem]
      result.add v.sample
    elif attr.isAttack:
      let atk = attr.fAttack
      let v = attackWords[gen.lang][atk]
      result.add v.sample

when isMainModule:
  randomize()
  echo generate()
