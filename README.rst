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

.. code-block:: Bash

   $ sayhissatsuwaza
   旋風雷光掌

   $ sayhissatsuwaza
   ホーリーピアース

   $ for x in $(seq 100); do sayhissatsuwaza; done | tr '\n' ' ' | fold -s
   紅蓮刃 暗黒剣 爆炎刃 旋風雷強撃 ブレイブブレイク
   エクスプロージョンクラッシュ 聖連突 疾風雷強撃 光連突
   列紅蓮列掌 闇業剣 ブレイブブレイク ライトスラスト
   フリーズウィンド アイシクルストーム 光業突 黒炎斬
   火炎斬 セイントピアース ライトピアース 旋風雷神掌
   フリーズストーム アイスストーム 風神雷神掌 暗黒刃
   アイスストーム 光列突 フリーズウィンド 強炎帝列掌
   セイントピアース 旋風雷神掌 セイントピアース
   ライトピアース フレイムブレード ファイアブレード
   連黒炎連掌 連爆炎強撃 光列突 ライトピアース
   アイシクルストーム 連火炎連撃 暗黒刃 ホーリースラスト
   ブレイブブレイク 聖列突 爆炎剣 強紅蓮連撃 旋風雷業撃
   光連突 疾風雷光掌 フリーズウィンド アイシクルストーム
   強黒炎列撃 聖業突 アイシクルストーム ライトスラスト
   ファイアスラッシュ 炎帝斬 強炎帝列掌 聖連突 黒炎剣
   列爆炎連掌 アイスウィンド フリーズストーム 連紅蓮列掌
   炎連刃 ファイナルクラッシュ フリーズウィンド
   風雷神連撃 ファイアソード フレイムスラッシュ
   ファイアソード 聖強突 ファイアブレード 紅蓮剣 紅蓮斬
   ライトスラスト 聖連突 ブレイブクラッシュ
   フレイムソード 旋風雷光掌 風雷光列掌 ファイナルブロウ
   業火炎業掌 風雷神連掌 闇強刃 闇列剣 光強突
   エクスプロージョンクラッシュ 光業突 旋風雷神掌
   風神雷光掌 聖強突 ブレイブブレイク 光連突 聖強突
   フレイムスラッシュ 暗黒刃 火炎刃 風雷光列撃

Web
------------

GitHub PagesにてWebUIからも必殺技を生成できるようにしている。

https://jiro4989.github.io/sayhissatsuwaza/

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
