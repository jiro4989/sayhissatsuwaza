import strutils, sequtils, tables, random

import types

proc generateCommon*(generators: seq[Generator],
                     elementWords: Table[Language, Table[ElementType, seq[
                         string]]],
                     attackWords: Table[Language, Table[AttackType, seq[
                         string]]],
                     lang: Language,
                     whitespace = " "): string =
  var ret: seq[string]
  let gen = generators.filterIt(it.lang == lang).sample
  for attr in gen.pattern:
    let v =
      case attr.kind
      of element: elementWords[lang][attr.fElement].sample
      of attack: attackWords[lang][attr.fAttack].sample
      else: ""
    ret.add v
  result = ret.join(whitespace)
