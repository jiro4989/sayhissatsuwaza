import tables, random
from unicode import toRunes

import ../types

const
  generators = @[
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
  ]

  elementWords = {
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

  attackWords = {
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

proc generate*(): string =
  ## 日本語の必殺技名をランダムに生成する。
  ## 関数内では乱数初期化をしないので、呼び出し側で制御すること。
  runnableExamples:
    import random
    randomize()
    echo generate()

  let gen = generators.sample
  for i, attr in gen.pattern:
    case attr.kind
    of element:
      result.add elementWords[gen.syllabary][attr.fElement].sample
    of attack:
      # 最後のattributeの時は文字数調整で奇数個になるようにする。
      # attackはいずれも1文字の漢字なので、奇数個の時は1文字の装飾とセットで結合して5文字になるようにする
      if gen.pattern.len == i+1 and
          gen.syllabary == kanji and
          result.toRunes.len mod 2 == 1:
        result.add elementWords[gen.syllabary][non].sample
      result.add attackWords[gen.syllabary][attr.fAttack].sample
    else: discard
