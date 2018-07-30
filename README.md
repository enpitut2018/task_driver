# ADHD予備軍 "task driver"

[![Build Status](https://travis-ci.org/enpitut2018/task_driver.svg?branch=master)](https://travis-ci.org/enpitut2018/task_driver)

We are developing this application for our course (enPiT) in University of Tsukuba. Our project's goal is making a TODO app that drives users to do their tasks.

## エレベーターピッチ
タスクの入力が面倒で、計画が立てられないことを解決したい。TODOリストが続かない人向けの、計画を提示するだけでなく、計画を実行させてくれる「タスクドライバー(仮)」です。  
これは、タスクの重みの数値化により計画を立て、実行のハードルを下げ、通知によりタスク入力を促し、Googleカレンダーとは違って、アプリがユーザを管理します。

##機能
最初にサイトを訪れると、アカウントを作ることになります。このときTwitterアカウントと連携するか自分のメールアドレスでアカウントを作るか選択できます。
サイトでアカウントを作ると、その後定期的にプッシュ通知が届くようになります。通知では今暇かどうかを聞いてくるので、暇であると答えるとタスク一覧ページに飛ぶことができます。
タスク一覧ページではより締め切りが近く重要なものが上に並んでいるので、何から手を付けるべきなのかが一目でわかるようになっています。また、現在のタスク状態（未着手、実行中、終了済み）ごとにカラムが分かれているので今まで行ったタスクもすぐに見ることができます。
タスクを実行する際はボタンを押して実行状態に切り替えます。この時とりかかりやすくすために、勢いよく音が出てユーザーの気持ちをアゲてくれます。さらに、twitterと連携をしている場合はタスクが開始した旨を自動でツイートしてフォロワーに通知されます。これにより周囲の目がある状態に自分をもっていくようになっています。
タスクが終了した場合もボタンを押して終了状態に切り替えます。この時も音が出て、ユーザーをねぎらってくれます。同時にツイッターにもタスクが終了した旨を投稿します。


##特徴
一般的なToDoアプリとは違って、入力したタスクの実行を定期的に促してくれます。既存のものでは締め切りが近くなった際に通知してくれるものはありますが、それとは違い計画的にコツコツとタスクをこなすための仕組みです。
また、家事をする際に好きな曲を流すとできるという人が多いというところから、タスクを開始すると音楽が流れるようにしています。
他人の目があるとちゃんとできるという声も多くあったことから、twitterと連携してフォロワーにタスクをこなすことを宣言するようになっています。
これらの機能により、タスクをやらなきゃいけないけど取り掛かるまでが長い・・・といった始めるまでの心理的なハードルをできるだけ下げることができます。

## links
* [application URL](https://task-driver.sukiyaki.party)
* [CI](https://travis-ci.org/enpitut2018/task_driver)

## members
[Chihiro Sato](https://github.com/lmn8cs)  
[Naoki Saruta](https://github.com/Kunado)  
[Reine Hakozaki](https://github.com/hakozaki-reine)  
[Ryoma Suizu](https://github.com/Ryoma-Suizu)  
[Satoshi Nishida](https://github.com/Nishida-Satoshi)  
[Yuki Oba](https://github.com/itumizu)