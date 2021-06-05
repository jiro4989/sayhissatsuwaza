import types
import sequtils

func combine*(part: PartOfSpeech, texts: seq[string], attrs: seq[
    Attribute]): seq[Word] =
  for text in texts:
    result.add Word(partOfSpeech: part, text: text, attrs: attrs)

func addAttr*(words: seq[Word], attr: Attribute): seq[Word] =
  for word in words:
    var w = word
    w.attrs.add attr
    result.add w

proc search*(words: seq[Word], cond: SearchCondition): seq[Word] =
  result = words
  # 品詞で絞り込み
  result = result.filterIt(it.partOfSpeech == cond.partOfSpeech)
  # conditionの属性すべてを満たすwordに絞り込みj
  for attr in cond.attrs:
    result = result.filterIt(attr in it.attrs)
