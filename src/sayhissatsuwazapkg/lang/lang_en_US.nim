import sequtils, random

import ../types2
import ../utils2

const
  words = concat(
    concat(
      combine(noun, @["Fire"], @[fire]),
      combine(noun, @["Ice"], @[ice]),
      combine(noun, @["Wind", "Storm"], @[wind]),
      combine(noun, @["Thunder", "Lightning"], @[thunder]),
      combine(noun, @["Saint", "Shine", "Holy"], @[holy]),
      combine(noun, @["Darkness"], @[darkness]),
    ).addAttr(element),
    concat(
      combine(noun, @["Slash", "Blade", "Sword"], @[slash]),
      combine(noun, @["Blow", "Attack", "Clash", "Break", "Strike"], @[blow]),
      combine(noun, @["Thrust", "Pierce"], @[thrust]),
    ).addAttr(attack),
    combine(noun, @["Absolute", "Power", "Final"], @[assist]),
  )

  patterns = @[
    @[
      SearchCondition(partOfSpeech: noun, attrs: @[element]),
      SearchCondition(partOfSpeech: noun, attrs: @[attack]),
    ],
    @[
      SearchCondition(partOfSpeech: noun, attrs: @[element]),
      SearchCondition(partOfSpeech: noun, attrs: @[attack]),
    ],
    @[
      SearchCondition(partOfSpeech: noun, attrs: @[assist]),
      SearchCondition(partOfSpeech: noun, attrs: @[attack]),
    ],
    @[
      SearchCondition(partOfSpeech: noun, attrs: @[ice]),
      SearchCondition(partOfSpeech: noun, attrs: @[wind]),
    ],
  ]

proc generate*(): string =
  ## 英語の必殺技名をランダムに生成する。
  ## 関数内では乱数初期化をしないので、呼び出し側で制御すること。
  runnableExamples:
    import random
    randomize()
    echo generate()

  let pattern = patterns.sample
  for i, cond in pattern:
    let word = words.search(cond).sample
    result.add word.text
