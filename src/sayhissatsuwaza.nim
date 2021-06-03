import tables, random, unicode

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

  Language {.pure.} = enum
    ## 言語。jaとenとしてるけれど、要は漢字のみならja, カタカナならen。
    ja, en

  Generator = object
    ## 必殺技名の組み合わせを定義したジェネレーター。
    ## 命名ルールと言語。
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
    Generator(lang: ja, pattern: @[attrWind, attrThunder, attrBlow]),
    Generator(lang: ja, pattern: @[attrHoly, attrThrust]),
    Generator(lang: ja, pattern: @[attrDarkness, attrSlash]),
    Generator(lang: ja, pattern: @[attrNon, attrFire, attrBlow]),
    Generator(lang: en, pattern: @[attrFire, attrSlash]),
    Generator(lang: en, pattern: @[attrHoly, attrThrust]),
    Generator(lang: en, pattern: @[attrNon, attrBlow]),
    Generator(lang: en, pattern: @[attrIce, attrWind]),
  ]

  elementWords = {
    ja: {
      non: @["強", "業", "連", "列"],
      fire: @["火炎", "紅蓮", "炎", "爆炎", "炎帝", "黒炎"],
      ice: @["氷結", "氷"],
      wind: @["風神", "疾風", "旋風", "風"],
      thunder: @["雷", "雷神", "雷光"],
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

proc generate*(): string =
  ## 必殺技名をランダムに生成する。
  ## 関数内では乱数初期化をしないので、呼び出し側で制御すること。
  runnableExamples:
    import random
    randomize()
    echo generate()

  let gen = generators.sample
  for i, attr in gen.pattern:
    case attr.kind
    of element:
      let elem = attr.fElement
      let v = elementWords[gen.lang][elem]
      result.add v.sample
    of attack:
      let atk = attr.fAttack
      var v = attackWords[gen.lang][atk]
      # 最後のattributeの時は文字数調整で奇数個になるようにする。
      # attackはいずれも1文字の漢字なので、奇数個の時は1文字の装飾とセットで結合して5文字になるようにする
      if gen.pattern.len == i+1 and
          gen.lang == ja and
          result.toRunes.len mod 2 == 1:
        result.add elementWords[gen.lang][non].sample
      result.add v.sample

proc cGenerate*(): cstring {.exportc.} =
  ## JSバックエンド用。
  return generate().cstring

when isMainModule and not defined js:
  import strformat

  const
    appName = "sayhissatsuwaza"
    version = &"""
{appName} command version 0.3.0
Copyright (c) 2021 jiro4989
Released under the MIT License.
https://github.com/jiro4989/{appName}"""

  proc log(msg: string) =
    echo &"{appName}: {msg}"

  proc sayhissatsuwaza(count = 1): int =
    if count <= 0:
      log "'count' parameter must be 1 or more."
      return 1

    randomize()
    for i in 1..count:
      echo generate()

  import cligen

  clCfg.version = version
  dispatch(sayhissatsuwaza,
    help = {
      "count": "loop counter",
    })