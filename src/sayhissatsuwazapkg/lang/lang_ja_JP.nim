import random, sequtils
from unicode import toRunes

import ../types2
import ../utils2

const
  words = concat(
    concat(
      concat(
        combine(noun, @["火炎", "紅蓮", "炎", "爆炎", "炎帝",
            "黒炎"], @[fire]),
        combine(noun, @["氷結", "氷"], @[ice]),
        combine(noun, @["風神", "疾風", "旋風", "風"], @[wind]),
        combine(noun, @["雷", "雷神", "雷光", "雷鳴", "電光"], @[
            thunder]),
        combine(noun, @["聖", "光"], @[holy]),
        combine(noun, @["闇", "暗黒"], @[darkness]),
    ).addAttr(element),
    concat(
      combine(noun, @["斬", "剣", "刃"], @[slash]),
      combine(noun, @["撃", "掌"], @[blow]),
      combine(noun, @["突"], @[thrust]),
    ).addAttr(attack),
    combine(noun, @["業", "連", "裂"], @[assist]),
  ).addAttr(kanji),

    concat(
      concat(
        combine(noun, @["ファイア", "フレイム"], @[fire]),
        combine(noun, @["アイス", "アイシクル", "フリーズ"], @[
            ice]),
        combine(noun, @["ウィンド", "ストーム"], @[wind]),
        combine(noun, @["サンダー", "プラズマ"], @[thunder]),
        combine(noun, @["セイント", "ホーリー", "ライト"], @[holy]),
        combine(noun, @["ダーク", "ダークネス"], @[darkness]),
    ).addAttr(element),
    concat(
      combine(noun, @["スラッシュ", "ブレード", "ソード"], @[
          slash]),
      combine(noun, @["ブロウ", "クラッシュ", "アタック",
          "ブレイク"], @[blow]),
      combine(noun, @["スラスト", "ピアース"], @[thrust]),
    ).addAttr(attack),
  ).addAttr(katakana),
  )

  patterns = @[
    @[
      SearchCondition(partOfSpeech: noun, attrs: @[kanji, element]),
      SearchCondition(partOfSpeech: noun, attrs: @[kanji, attack]),
    ],
    @[
      SearchCondition(partOfSpeech: noun, attrs: @[katakana, element]),
      SearchCondition(partOfSpeech: noun, attrs: @[katakana, attack]),
    ],
    @[
      SearchCondition(partOfSpeech: noun, attrs: @[kanji, assist]),
      SearchCondition(partOfSpeech: noun, attrs: @[kanji, element]),
      SearchCondition(partOfSpeech: noun, attrs: @[kanji, attack]),
    ],
    @[
      SearchCondition(partOfSpeech: noun, attrs: @[kanji, wind]),
      SearchCondition(partOfSpeech: noun, attrs: @[kanji, thunder]),
      SearchCondition(partOfSpeech: noun, attrs: @[kanji, attack]),
    ],
  ]

proc generate*(): string =
  ## 日本語の必殺技名をランダムに生成する。
  ## 関数内では乱数初期化をしないので、呼び出し側で制御すること。
  runnableExamples:
    import random
    randomize()
    echo generate()

  let pattern = patterns.sample
  for i, cond in pattern:
    let word = words.search(cond).sample
    # 最後のattributeの時は文字数調整で奇数個になるようにする。
    # attackはいずれも1文字の漢字なので、奇数個の時は1文字の装飾とセットで結合して5文字になるようにする
    if pattern.len == i+1 and
        kanji in cond.attrs and
        result.toRunes.len mod 2 == 1:
      let matched = words
        .search(SearchCondition(partOfSpeech: noun, attrs: @[kanji, assist]))
        .filterIt(it.text.toRunes[0] notin result.toRunes)
      if 0 < matched.len:
        result.add matched.sample.text
    result.add word.text

when isMainModule:
  randomize()
  for i in 1..1000:
    echo generate()
