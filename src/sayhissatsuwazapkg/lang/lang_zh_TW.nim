import tables

import ../types
import ../utils

const
  generators = @[
    Generator(lang: zhTW, pattern: @[attrFire, attrSlash]),
    Generator(lang: zhTW, pattern: @[attrHoly, attrThrust]),
    Generator(lang: zhTW, pattern: @[attrNon, attrBlow]),
    Generator(lang: zhTW, pattern: @[attrIce, attrWind]),
  ]

  elementWords = {
    zhTW: {
      non: @["強"],
      fire: @["火焰", "紅蓮", "爆炸"],
      ice: @["凍結", "冰"],
      wind: @["旋風"],
      thunder: @["雷神"],
      holy: @["光", "聖"],
      darkness: @["黑暗"],
    }.toTable,
  }.toTable

  attackWords = {
    zhTW: {
      slash: @["殺", "刀", "劍"],
      blow: @["打"],
      thrust: @["刺"],
    }.toTable,
  }.toTable

proc generate*(): string =
  ## 中国語(繁体字)の必殺技名をランダムに生成する。
  ## 関数内では乱数初期化をしないので、呼び出し側で制御すること。
  runnableExamples:
    import random
    randomize()
    echo generate()

  result = generateCommon(generators, elementWords, attackWords, zhTW, "")
