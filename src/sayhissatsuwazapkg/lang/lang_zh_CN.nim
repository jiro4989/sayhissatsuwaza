import tables, random

import ../types

const
  generators = @[
    Generator(lang: zhCN, pattern: @[attrFire, attrSlash]),
    Generator(lang: zhCN, pattern: @[attrHoly, attrThrust]),
    Generator(lang: zhCN, pattern: @[attrNon, attrBlow]),
    Generator(lang: zhCN, pattern: @[attrIce, attrWind]),
    Generator(lang: zhCN, pattern: @[attrVerbCommon, attrNounCommon,
        attrSlash]),
  ]

  elementWords = {
    non: @["强"],
    fire: @["火焰", "红莲", "爆炸"],
    ice: @["冷冻"],
    wind: @["旋风"],
    thunder: @["雷神"],
    holy: @["光"],
    darkness: @["黑暗"],
  }.toTable

  attackWords = {
    slash: @["剑法", "刀法"],
    blow: @["打"],
    thrust: @["剑"],
  }.toTable

  verbWords = {
    VerbType.common: @["夺命", "辟"],
  }.toTable

  nounWords = {
    NounType.common: @["十五", "魔", "邪"],
  }.toTable


proc generate*(): string =
  ## 中国語(簡体字)の必殺技名をランダムに生成する。
  ## 関数内では乱数初期化をしないので、呼び出し側で制御すること。
  runnableExamples:
    import random
    randomize()
    echo generate()

  let gen = generators.sample
  for attr in gen.pattern:
    let v =
      case attr.kind
      of element: elementWords[attr.fElement].sample
      of attack: attackWords[attr.fAttack].sample
      of verb: verbWords[attr.fVerb].sample
      of noun: nounWords[attr.fNoun].sample
    result.add v
