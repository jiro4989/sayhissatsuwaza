import strutils, sequtils, tables, random
from unicode import toRunes

type
  ElementType {.pure.} = enum
    ## 要素。炎とか氷とか。
    non, fire, ice, wind, thunder, holy, darkness

  AttackType {.pure.} = enum
    ## 攻撃の種類。斬撃、打撃、刺突。
    slash, blow, thrust

  Kind {.pure.} = enum
    ## 属性の種類。
    element, attack

  Attribute = object
    ## ElementとAttackをラップして1つの型にラッピングしたもの。
    ## Generatorで1つの型として扱うために存在する。
    case kind: Kind
    of element:
      fElement: ElementType
    of attack:
      fAttack: AttackType

  Syllabary {.pure.} = enum
    ## 音節。Language = jaの時だけ使用する。
    kanji, katakana

  Generator = object
    ## 必殺技名の組み合わせを定義したジェネレーター。
    ## 命名ルールと言語。
    lang: Language
    syllabary: Syllabary ## lang = ja の時だけ使用する。
    pattern: seq[Attribute]

  Language* = enum
    ja = "ja_JP"
    en = "en_US"
    zhCN = "zh_CN"
    zhTW = "zh_TW"

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
    # Japanese
    Generator(lang: ja, syllabary: kanji, pattern: @[attrFire, attrSlash]),
    Generator(lang: ja, syllabary: kanji, pattern: @[attrWind, attrThunder,
        attrBlow]),
    Generator(lang: ja, syllabary: kanji, pattern: @[attrHoly, attrThrust]),
    Generator(lang: ja, syllabary: kanji, pattern: @[attrDarkness, attrSlash]),
    Generator(lang: ja, syllabary: kanji, pattern: @[attrNon, attrFire,
        attrBlow]),
    Generator(lang: ja, syllabary: katakana, pattern: @[attrFire, attrSlash]),
    Generator(lang: ja, syllabary: katakana, pattern: @[attrHoly, attrThrust]),
    Generator(lang: ja, syllabary: katakana, pattern: @[attrNon, attrBlow]),
    Generator(lang: ja, syllabary: katakana, pattern: @[attrIce, attrWind]),

    # English
    Generator(lang: en, pattern: @[attrFire, attrSlash]),
    Generator(lang: en, pattern: @[attrHoly, attrThrust]),
    Generator(lang: en, pattern: @[attrNon, attrBlow]),
    Generator(lang: en, pattern: @[attrIce, attrWind]),

    # Chinese
    Generator(lang: zhCN, pattern: @[attrFire, attrSlash]),
    Generator(lang: zhCN, pattern: @[attrHoly, attrThrust]),
    Generator(lang: zhCN, pattern: @[attrNon, attrBlow]),
    Generator(lang: zhCN, pattern: @[attrIce, attrWind]),

    Generator(lang: zhTW, pattern: @[attrFire, attrSlash]),
    Generator(lang: zhTW, pattern: @[attrHoly, attrThrust]),
    Generator(lang: zhTW, pattern: @[attrNon, attrBlow]),
    Generator(lang: zhTW, pattern: @[attrIce, attrWind]),
  ]

  elementWordsJapanese = {
    kanji: {
      non: @["強", "業", "連", "列"],
      fire: @["火炎", "紅蓮", "炎", "爆炎", "炎帝", "黒炎"],
      ice: @["氷結", "氷"],
      wind: @["風神", "疾風", "旋風", "風"],
      thunder: @["雷", "雷神", "雷光"],
      holy: @["聖", "光"],
      darkness: @["闇", "暗黒"],
    }.toTable,
    katakana: {
      non: @["ブレイブ", "エクスプロージョン", "ファイナル"],
      fire: @["ファイア", "フレイム"],
      ice: @["アイス", "アイシクル", "フリーズ"],
      wind: @["ウィンド", "ストーム"],
      thunder: @["サンダー", "プラズマ"],
      holy: @["セイント", "ホーリー", "ライト"],
      darkness: @["ダーク", "ダークネス"],
    }.toTable,
  }.toTable

  elementWordsCommon = {
    en: {
      non: @["Absolute", "Power", "Final"],
      fire: @["Fire"],
      ice: @["Ice"],
      wind: @["Wind", "Storm"],
      thunder: @["Thunder", "Lightning"],
      holy: @["Saint", "Shine", "Holy"],
      darkness: @["Darkness"],
    }.toTable,
    zhCN: {
      non: @["強", "業", "連", "列"],
      fire: @["Fire"],
      ice: @["Ice"],
      wind: @["Wind", "Storm"],
      thunder: @["Thunder", "Lightning"],
      holy: @["Saint", "Shine", "Holy"],
      darkness: @["Darkness"],
    }.toTable,
    zhTW: {
      non: @["強", "業", "連", "列"],
      fire: @["Fire"],
      ice: @["Ice"],
      wind: @["Wind", "Storm"],
      thunder: @["Thunder", "Lightning"],
      holy: @["Saint", "Shine", "Holy"],
      darkness: @["Darkness"],
    }.toTable,
  }.toTable

  attackWordsJapanese = {
    kanji: {
      slash: @["斬", "剣", "刃"],
      blow: @["撃", "掌"],
      thrust: @["突"],
    }.toTable,
    katakana: {
      slash: @["スラッシュ", "ブレード", "ソード"],
      blow: @["ブロウ", "クラッシュ", "アタック", "ブレイク"],
      thrust: @["スラスト", "ピアース"],
    }.toTable,
  }.toTable

  attackWordsCommon = {
    en: {
      slash: @["Slash", "Blade", "Sword"],
      blow: @["Blow", "Attack", "Clash", "Break", "Strike"],
      thrust: @["Thrust", "Pierce"],
    }.toTable,
    zhCN: {
      slash: @["スラッシュ", "ブレード", "ソード"],
      blow: @["ブロウ", "クラッシュ", "アタック", "ブレイク"],
      thrust: @["スラスト", "ピアース"],
    }.toTable,
    zhTW: {
      slash: @["スラッシュ", "ブレード", "ソード"],
      blow: @["ブロウ", "クラッシュ", "アタック", "ブレイク"],
      thrust: @["スラスト", "ピアース"],
    }.toTable,
  }.toTable

proc generateJapaneseHissatsuwaza*(): string =
  ## 日本語の必殺技名をランダムに生成する。
  ## 関数内では乱数初期化をしないので、呼び出し側で制御すること。
  runnableExamples:
    import random
    randomize()
    echo generateJapaneseHissatsuwaza()

  let gen = generators.filterIt(it.lang == ja).sample
  for i, attr in gen.pattern:
    case attr.kind
    of element:
      result.add elementWordsJapanese[gen.syllabary][attr.fElement].sample
    of attack:
      # 最後のattributeの時は文字数調整で奇数個になるようにする。
      # attackはいずれも1文字の漢字なので、奇数個の時は1文字の装飾とセットで結合して5文字になるようにする
      if gen.pattern.len == i+1 and
          gen.syllabary == kanji and
          result.toRunes.len mod 2 == 1:
        result.add elementWordsJapanese[gen.syllabary][non].sample
      result.add attackWordsJapanese[gen.syllabary][attr.fAttack].sample

proc generateCommon*(lang: Language, whitespace = " "): string =
  var ret: seq[string]
  let gen = generators.filterIt(it.lang == lang).sample
  for attr in gen.pattern:
    let v =
      case attr.kind
      of element: elementWordsCommon[lang][attr.fElement].sample
      of attack: attackWordsCommon[lang][attr.fAttack].sample
    ret.add v
  result = ret.join(whitespace)

proc generateEnglishHissatsuwaza*(): string =
  ## 英語の必殺技名をランダムに生成する。
  ## 関数内では乱数初期化をしないので、呼び出し側で制御すること。
  runnableExamples:
    import random
    randomize()
    echo generateEnglishHissatsuwaza()

  result = generateCommon(en)

proc generateChineseCNHissatsuwaza*(): string =
  ## 中国語(簡体字)の必殺技名をランダムに生成する。
  ## 関数内では乱数初期化をしないので、呼び出し側で制御すること。
  runnableExamples:
    import random
    randomize()
    echo generateChineseCNHissatsuwaza()

  result = generateCommon(zhCN, "")

proc generateChineseTWHissatsuwaza*(): string =
  ## 中国語(繁体字)の必殺技名をランダムに生成する。
  ## 関数内では乱数初期化をしないので、呼び出し側で制御すること。
  runnableExamples:
    import random
    randomize()
    echo generateChineseTWHissatsuwaza()

  result = generateCommon(zhTW, "")

proc generate*(lang = ja): string =
  ## 必殺技名をランダムに生成する。
  ## 関数内では乱数初期化をしないので、呼び出し側で制御すること。
  runnableExamples:
    import random
    randomize()
    echo generate(ja)

  case lang
  of ja: generateJapaneseHissatsuwaza()
  of en: generateEnglishHissatsuwaza()
  of zhCN: generateChineseCNHissatsuwaza()
  of zhTW: generateChineseTWHissatsuwaza()

proc cGenerate*(): cstring {.exportc.} =
  ## JSバックエンド用。
  return generate().cstring

when isMainModule and not defined js:
  import strformat, logging, os

  const
    appName = "sayhissatsuwaza"
    version = &"""
{appName} command version 0.4.0
Copyright (c) 2021 jiro4989
Released under the MIT License.
https://github.com/jiro4989/{appName}"""

  addHandler(newConsoleLogger(fmtStr = verboseFmtStr, useStderr = true))

  proc getLanguage: Language =
    ## 環境変数から言語を読み取ってenumオブジェクトに変換する。
    result = ja
    let envLang = getEnv("LANG")
    if envLang == "": return
    let lang = envLang.split(".")[0]
    result =
      case lang
      of $ja: ja
      of $en: en
      of $zhCN: zhCN
      of $zhTW: zhTW
      else: ja

  proc sayhissatsuwaza(count = 1): int =
    if count <= 0:
      info "'count' parameter must be 1 or more."
      return 1

    let lang = getLanguage()

    randomize()
    for i in 1..count:
      echo generate(lang)

  import cligen

  clCfg.version = version
  dispatch(sayhissatsuwaza,
    help = {
      "count": "loop counter",
    })
