import tables

import ../types
import ../utils

const
  generators = @[
    Generator(lang: en, pattern: @[attrFire, attrSlash]),
    Generator(lang: en, pattern: @[attrHoly, attrThrust]),
    Generator(lang: en, pattern: @[attrNon, attrBlow]),
    Generator(lang: en, pattern: @[attrIce, attrWind]),
  ]

  elementWords = {
    en: {
      non: @["Absolute", "Power", "Final"],
      fire: @["Fire"],
      ice: @["Ice"],
      wind: @["Wind", "Storm"],
      thunder: @["Thunder", "Lightning"],
      holy: @["Saint", "Shine", "Holy"],
      darkness: @["Darkness"],
    }.toTable,
  }.toTable

  attackWords = {
    en: {
      slash: @["Slash", "Blade", "Sword"],
      blow: @["Blow", "Attack", "Clash", "Break", "Strike"],
      thrust: @["Thrust", "Pierce"],
    }.toTable,
  }.toTable

proc generate*(): string =
  ## 英語の必殺技名をランダムに生成する。
  ## 関数内では乱数初期化をしないので、呼び出し側で制御すること。
  runnableExamples:
    import random
    randomize()
    echo generate()

  result = generateCommon(generators, elementWords, attackWords, en)
