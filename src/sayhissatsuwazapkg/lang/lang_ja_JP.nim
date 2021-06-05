import tables, random, sequtils
from unicode import toRunes

# import ../types

type
  Attribute = enum
    kanji, katakana,
    element, non, fire, ice, wind, thunder, holy, darkness,
    attack, slash, blow, thrust,
    assist

  PartOfSpeech {.pure.} = enum
    ## 品詞。
    verb, # 動詞
    noun  # 名詞

  Word = object
    partOfSpeech: PartOfSpeech
    attrs: seq[Attribute]
    text: string

  SearchCondition = object
    partOfSpeech: PartOfSpeech
    attrs: seq[Attribute]

func atk(text: string, attrs: seq[Attribute]): Word =
  var a = @[attack]
  a.add attrs
  result = Word(partOfSpeech: noun, attrs: a, text: text)

func atks(texts: seq[string], attrs: seq[Attribute]): seq[Word] =
  for text in texts:
    result.add atk(text, attrs)

func elem(text: string, attrs: seq[Attribute]): Word =
  var a = @[element]
  a.add attrs
  result = Word(partOfSpeech: noun, attrs: a, text: text)

func elems(texts: seq[string], attrs: seq[Attribute]): seq[Word] =
  for text in texts:
    result.add elem(text, attrs)

func assistWord(text: string, attrs: seq[Attribute]): Word =
  var a = @[assist]
  a.add attrs
  result = Word(partOfSpeech: noun, attrs: a, text: text)

func assistWords(texts: seq[string], attrs: seq[Attribute]): seq[Word] =
  for text in texts:
    result.add assistWord(text, attrs)

func cond(p: PartOfSpeech, a: seq[Attribute]): SearchCondition =
  SearchCondition(partOfSpeech: p, attrs: a)

const
  words = concat(
    elems(@["火炎", "紅蓮", "炎", "爆炎", "炎帝", "黒炎"], @[fire,
        kanji]),
    elems(@["氷結", "氷"], @[ice, kanji]),
    elems(@["風神", "疾風", "旋風", "風"], @[wind, kanji]),
    elems(@["雷", "雷神", "雷光", "雷鳴", "電光"], @[thunder, kanji]),
    elems(@["聖", "光"], @[holy, kanji]),
    elems(@["闇", "暗黒"], @[darkness, kanji]),

    assistWords(@["強", "業", "連", "列"], @[kanji]),

    elems(@["ファイア", "フレイム"], @[fire, katakana]),
    elems(@["アイス", "アイシクル", "フリーズ"], @[ice, katakana]),
    elems(@["ウィンド", "ストーム"], @[wind, katakana]),
    elems(@["サンダー", "プラズマ"], @[thunder, katakana]),
    elems(@["セイント", "ホーリー", "ライト"], @[holy, katakana]),
    elems(@["ダーク", "ダークネス"], @[darkness, katakana]),

    atks(@["斬", "剣", "刃"], @[slash, kanji]),
    atks(@["撃", "掌"], @[blow, kanji]),
    atks(@["突"], @[thrust, kanji]),

    atks(@["スラッシュ", "ブレード", "ソード"], @[slash, katakana]),
    atks(@["ブロウ", "クラッシュ", "アタック", "ブレイク"], @[
        blow, katakana]),
    atks(@["スラスト", "ピアース"], @[thrust, katakana]),

  )

  patterns = @[
    @[cond(noun, @[kanji, element]), cond(noun, @[kanji, attack])],
    @[cond(noun, @[katakana, element]), cond(noun, @[katakana, attack])],
  ]

proc search(words: seq[Word], cond: SearchCondition): seq[Word] =
  result = words
  # 品詞で絞り込み
  result = result.filterIt(it.partOfSpeech == cond.partOfSpeech)
  # conditionの属性すべてを満たすwordに絞り込みj
  for attr in cond.attrs:
    result = result.filterIt(attr in it.attrs)

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
      let matched = words.search(SearchCondition(partOfSpeech: noun, attrs: @[
          kanji, assist]))
      if 0 < matched.len:
        result.add matched.sample.text
    result.add word.text

when isMainModule:
  randomize()
  for i in 1..1000:
    echo generate()
