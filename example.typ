#import "@preview/physica:0.9.2": *
#import "systemB.typ": *

#show: graduation_thesis.with(
  title: "タイトル",
  your_name_jp: "東大太郎",
  your_name_en: "Taro Todai",
  student_id: "XX-XXXXXX",
  mentor_name: "東大花子",
  mentor_position: "教授",
  write_year: "2024",
  write_month: "1",
  abstract: "ここに概要を書く．",
  bibliography-file: "./references.bib",
)

= 序章
これは計数工学科システム情報コースの卒業論文をTypstに移植したものです．
== 題名
```
#import "systemB.typ": *

#show: graduation_thesis.with(
  title: "タイトル",
  your_name_jp: "東大太郎",
  your_name_en: "Taro Todai",
  student_id: "XX-XXXXXX",
  mentor_name: "東大花子",
  mentor_position: "教授",
  write_year: "2024",
  write_month: "1",
  abstract: "ここに概要を書く．",
  bibliography-file: "./references.bib",
)
```
というようにファイルの先頭に書くと，卒業論文の書式が設定されます．
=== bibliography-file について
`@Kingma2014` のような感じで引用すると勝手に参考文献に追加されます@Kingma2014．私はMendeleyから使う文献をまとめてBibTeX形式で出力して，それを指定しています．使わない論文は表示されないので，この方法がいいかなと思っています．

== ページについて
本家(LaTeX)版では奇数ページは右側に，偶数ページは左側にページ番号が表示されるようになっているので，それを再現しています．
#pagebreak()
例えばこんな感じで，章をまたぐ際はどこの章に属しているかがわかるようになっています．
#pagebreak()
奇数ページの場合はどこの節に属しているかがわかるようになっています．
#pagebreak()

= 本文
章が変わるページの場合はページのみが表示されるはずです．なお，`#heading`を入れても改ページされるようにはなっていないので自分で`#pagebreak()`してください．
== 数式
$
nabla dot vb(B) = 0
$
式番号は章ごとにリセットされます．

== 図
図も挿入できます．
#figure(image("example.jpg"), caption: "図の説明")

#pagebreak()
== 表
#figure(
  table(
    columns: (1fr, 1fr),
    table.header([*A*], [*B*]),
    [content 1], [content 2],
  ),
  caption: "表の説明は上にきます"
)


#pagebreak()

// 見出しのないheading
#chap[謝辞]
何か不明な点や不具合があればissue立ててください．主に#link("https://zenn.dev/chantakan/articles/ed80950004d145")を参考にしました．