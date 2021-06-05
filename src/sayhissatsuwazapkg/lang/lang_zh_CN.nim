import sequtils, random

import ../types
import ../utils

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
    combine(verb, @["夺", "辟"], @[]),
    combine(noun, @["命", "魂", "魔"], @[attrObject]),
    combine(noun, @["剑法", "刀法"], @[technique]),
    combine(noun, @["十字"], @[shape]),
    combine(noun, @["十", "十五", "百", "千"], @[Attribute.count]),
  )

  patterns = @[
    @[
      SearchCondition(partOfSpeech: noun, attrs: @[element]),
      SearchCondition(partOfSpeech: noun, attrs: @[attack]),
    ],
    @[
      SearchCondition(partOfSpeech: noun, attrs: @[element]),
      SearchCondition(partOfSpeech: noun, attrs: @[technique]),
    ],
    @[
      SearchCondition(partOfSpeech: verb, attrs: @[]),
      SearchCondition(partOfSpeech: noun, attrs: @[attrObject]),
      SearchCondition(partOfSpeech: noun, attrs: @[technique]),
    ],
    @[
      SearchCondition(partOfSpeech: verb, attrs: @[]),
      SearchCondition(partOfSpeech: noun, attrs: @[attrObject]),
      SearchCondition(partOfSpeech: noun, attrs: @[shape]),
      SearchCondition(partOfSpeech: noun, attrs: @[slash]),
    ],
    @[
      SearchCondition(partOfSpeech: verb, attrs: @[]),
      SearchCondition(partOfSpeech: noun, attrs: @[attrObject]),
      SearchCondition(partOfSpeech: noun, attrs: @[Attribute.count]),
      SearchCondition(partOfSpeech: noun, attrs: @[slash]),
    ],
  ]

proc generate*(): string =
  ## 中国語(簡体字)の必殺技名をランダムに生成する。
  ## 関数内では乱数初期化をしないので、呼び出し側で制御すること。
  runnableExamples:
    import random
    randomize()
    echo generate()

  let pattern = patterns.sample
  for i, cond in pattern:
    let word = words.search(cond).sample
    result.add word.text
