import sequtils, random

import ../types2
import ../utils2

const
  words = concat(
    concat(
      combine(noun, @["火焰", "红莲", "爆炸"], @[fire]),
      combine(noun, @["冷冻"], @[ice]),
      combine(noun, @["旋风"], @[wind]),
      combine(noun, @["雷神"], @[thunder]),
      combine(noun, @["光"], @[holy]),
      combine(noun, @["黑暗"], @[darkness]),
    ).addAttr(element),
    concat(
      combine(noun, @["剑", "刀"], @[slash]),
      combine(noun, @["打"], @[blow]),
      combine(noun, @["剑"], @[thrust]),
    ).addAttr(attack),
    combine(noun, @["强"], @[assist]),
  )

  patterns = @[
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