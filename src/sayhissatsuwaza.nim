import sayhissatsuwazapkg/types
import sayhissatsuwazapkg/lang/lang_ja_JP
import sayhissatsuwazapkg/lang/lang_en_US
import sayhissatsuwazapkg/lang/lang_zh_CN
import sayhissatsuwazapkg/lang/lang_zh_TW

proc generate*(lang = ja): string =
  ## 必殺技名をランダムに生成する。
  ## 関数内では乱数初期化をしないので、呼び出し側で制御すること。
  runnableExamples:
    import random
    randomize()
    echo generate(ja)

  case lang
  of ja: lang_ja_JP.generate()
  of en: lang_en_US.generate()
  of zhCN: lang_zh_CN.generate()
  of zhTW: lang_zh_TW.generate()

func languageCode2Language(lang: string): Language =
  result =
    case lang
    of $ja: ja
    of $en: en
    of $zhCN: zhCN
    of $zhTW: zhTW
    else: ja

proc cGenerate*(lang = cstring"ja_JP"): cstring {.exportc.} =
  ## JSバックエンド用。
  let l = ($lang).languageCode2Language
  return generate(l).cstring

when isMainModule and not defined js:
  import strutils, strformat, logging, os, random

  const
    appName = "sayhissatsuwaza"
    version = &"""
{appName} command version 0.8.0
Copyright (c) 2021 jiro4989
Released under the MIT License.
https://github.com/jiro4989/{appName}"""

  addHandler(newConsoleLogger(fmtStr = verboseFmtStr, useStderr = true))

  proc getLanguageByEnv: Language =
    ## 環境変数から言語を読み取ってenumオブジェクトに変換する。
    result = ja
    let envLang = getEnv("LANG")
    if envLang == "": return
    let lang = envLang.split(".")[0]
    result = lang.languageCode2Language

  proc sayhissatsuwaza(count = 1, language = ""): int =
    if count <= 0:
      info "'count' parameter must be 1 or more."
      return 1

    let lang =
      if language != "": language.languageCode2Language
      else: getLanguageByEnv()

    randomize()
    for i in 1..count:
      echo generate(lang)

  import cligen

  clCfg.version = version
  dispatch(sayhissatsuwaza,
    help = {
      "count": "loop counter",
      "language": "language (ja_JP, en_US, zh_CN, zh_TW)",
    })
