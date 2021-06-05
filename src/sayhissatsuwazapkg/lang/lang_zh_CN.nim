import tables

import ../types
import ../utils

const
  generators = @[
    Generator(lang: zhCN, pattern: @[attrFire, attrSlash]),
    Generator(lang: zhCN, pattern: @[attrHoly, attrThrust]),
    Generator(lang: zhCN, pattern: @[attrNon, attrBlow]),
    Generator(lang: zhCN, pattern: @[attrIce, attrWind]),
  ]

  elementWords = {
    zhCN: {
      non: @["强"],
      fire: @["火焰", "红莲", "爆炸"],
      ice: @["冷冻"],
      wind: @["旋风"],
      thunder: @["雷神"],
      holy: @["光"],
      darkness: @["黑暗"],
    }.toTable,
  }.toTable

  attackWords = {
    zhCN: {
      slash: @["剑", "刀"],
      blow: @["打"],
      thrust: @["剑"],
    }.toTable,
  }.toTable

proc generate*(): string =
  ## 中国語(簡体字)の必殺技名をランダムに生成する。
  ## 関数内では乱数初期化をしないので、呼び出し側で制御すること。
  runnableExamples:
    import random
    randomize()
    echo generate()

  result = generateCommon(generators, elementWords, attackWords, zhCN, "")
