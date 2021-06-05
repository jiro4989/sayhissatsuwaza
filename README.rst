=====
sayhissatsuwaza
=====

|nimble-version| |nimble-install| |nimble-docs| |gh-actions|

コマンドラインだって必殺技を叫びたい。

.. contents:: Table of contents
   :depth: 3

Installation
============

以下のコマンドを実行する。

.. code-block:: Bash

   nimble install -Y sayhissatsuwaza

または

`GitHub Releases <https://github.com/jiro4989/sayhissatsuwaza/releases>`_ からダウンロードする。

Usage
=====

Command
-------

ボキャ貧なので生成される必殺技名のパターンが少ない。

普通に実行する場合は以下。

.. code-block:: Bash

   $ sayhissatsuwaza
   旋風雷光掌

   $ sayhissatsuwaza
   ホーリーピアース

出力する必殺技の数を変更する場合は `-c` で数を指定する。

.. code-block:: Bash

   $ sayhissatsuwaza -c 100 | tr \\n ' ' | fold -s
   フレイムソード 聖強突 フレイムスラッシュ 風雷光業撃
   業爆炎強撃 フリーズウィンド ホーリースラスト 光連突
   炎強剣 連炎掌 フレイムブレード 闇強刃 連炎帝強掌
   炎帝剣 強紅蓮業撃 列炎帝強撃 旋風雷光撃 暗黒剣
   ファイアブレード 業爆炎連撃 暗黒斬 聖強突 暗黒剣
   暗黒刃 聖強突 ブレイブアタック アイスストーム
   ファイアソード 光列突 エクスプロージョンアタック
   強炎帝業撃 フリーズウィンド ファイナルブレイク
   アイシクルストーム 疾風雷神掌 セイントスラスト
   疾風雷光掌 疾風雷強撃 連紅蓮列撃 暗黒剣
   フリーズウィンド 光業突 アイシクルウィンド 風雷神連撃
   アイスストーム ファイアスラッシュ セイントピアース
   ファイアブレード 光列突 暗黒斬 アイシクルストーム
   連爆炎連撃 ブレイブクラッシュ 炎業剣 爆炎刃
   フリーズストーム アイスストーム 闇列剣 アイスウィンド
   火炎剣 ホーリーピアース 炎業剣 セイントスラスト 火炎剣
   フリーズストーム アイスストーム 暗黒刃 旋風雷神掌
   業炎帝業掌 聖業突 火炎剣 アイシクルストーム 光業突
   炎帝刃 炎強刃 暗黒斬 暗黒斬 アイスストーム
   セイントスラスト 闇列刃 業爆炎業撃 アイシクルウィンド
   暗黒剣 セイントピアース 聖列突 疾風雷神撃 疾風雷光掌
   ファイアスラッシュ 強爆炎連撃 ファイナルアタック
   暗黒刃 強火炎連撃 風雷掌 風神雷神撃 聖列突
   アイシクルストーム ブレイブアタック ライトピアース
   ライトピアース 旋風雷光掌

必殺技の言語を指定する場合は環境変数 `LANG` を設定するか、
`-l` オプションを指定する。

.. code-block:: Bash

   $ sayhissatsuwaza -l en_US
   Ice Wind

   $ export LANG=en_US.UTF-8
   $ sayhissatsuwaza
   Final Break

Web
------------

GitHub PagesにてWebUIからも必殺技を生成できるようにしている。

https://jiro4989.github.io/sayhissatsuwaza/

Supported Languages
===================

以下の言語に対応していますが、日本語以外の言語の必殺技は正しいのかどうか正直わからないです。
日本語以外の言語圏における必殺技に明るい方からのPull requestお待ちしてます。

* 日本語
* 英語
* 中国語

Pull request
============

お待ちしてます

LICENSE
=======

MIT

.. |gh-actions| image:: https://github.com/jiro4989/sayhissatsuwaza/workflows/test/badge.svg
   :target: https://github.com/jiro4989/sayhissatsuwaza/actions
.. |nimble-version| image:: https://nimble.directory/ci/badges/sayhissatsuwaza/version.svg
   :target: https://nimble.directory/ci/badges/sayhissatsuwaza/nimdevel/output.html
.. |nimble-install| image:: https://nimble.directory/ci/badges/sayhissatsuwaza/nimdevel/status.svg
   :target: https://nimble.directory/ci/badges/sayhissatsuwaza/nimdevel/output.html
.. |nimble-docs| image:: https://nimble.directory/ci/badges/sayhissatsuwaza/nimdevel/docstatus.svg
   :target: https://nimble.directory/ci/badges/sayhissatsuwaza/nimdevel/doc_build_output.html
