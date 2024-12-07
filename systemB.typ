#let graduation_thesis(
  title: "",
  student_id: "",
  your_name_jp: "",
  your_name_en: "",
  mentor_name: "",
  mentor_position: "",
  write_year: "",
  write_month: "",
  abstract: "",
  bibliography-file: "", 
  body
) = {
  // テキストの設定
  set text(
    font: (
      "Noto Serif JP",
      "Times New Roman",
    ),
    size: 10pt,

  )

  // ページの設定
  set page(
    paper: "a4",
    margin: (
      bottom: 1.75cm, top: 2.5cm,
      left: 3cm, right: 3cm
    ),
    numbering: none
  )

  // 段落の設定
  set par(leading: 1.008em, first-line-indent: 1em, justify: true)

  // 見出しの設定
  set heading(numbering: "1.1.1.1")
  show heading: set text(font: "Noto Serif JP", weight: "bold", size: 12pt)

  show heading.where(level: 1): it => {
    set par(first-line-indent: 0pt,leading: 0em)
    counter(math.equation).update(0)
    v(60pt)
    text(weight: "bold", size: 22pt, font: "Zen Kaku Gothic Antique")[
      #if it.numbering != none {
        numbering("第1章", ..counter(heading).at(it.location()))
      }
    ]
    v(22pt)
    text(weight: "bold", size: 22pt, font: "Zen Kaku Gothic Antique")[#it.body \ ]
  }

  show heading.where(level: 2): it => {
    set par(first-line-indent: 0pt, leading: 0em)
    par(text(size: 1em, ""))    
    text(weight: "bold", size: 14pt, font: "Noto Serif JP")[
      #if it.numbering != none {
        numbering("1.1.1.1", ..counter(heading).at(it.location()))
      }
    ]
    text(weight: "bold", size: 14pt)[#it.body \ ]
    par(text(size: 1em, ""))
  }

  show heading.where(level: 3): it => {
    set par(first-line-indent: 0pt,leading: 0em)
    par(text(size: 0.45em, ""))    
    text(weight: "bold", size: 12pt, font: "Noto Serif JP")[
      #if it.numbering != none {
        numbering("1.1.1.1", ..counter(heading).at(it.location()))
      }
    ]
    text(weight: "bold", size: 12pt)[#it.body \ ]
    par(text(size: 0.75em, ""))    
  }

  // 表のfigureの設定
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): set figure(supplement: "表")

  // 図の設定
  set figure(supplement: "図")

  // 数式の設定
  set math.equation(numbering: num =>
    "(" + ((counter(heading).get().at(0),) + (num,)).map(str).join(".") + ")", supplement: "式")

  // ページ番号の設定
  show ref: it => {
    if it.element != none and it.element.func() == figure {
      let el = it.element
      let loc = el.location()
      let chapt = counter(heading).at(loc).at(0)

      link(loc)[#if el.kind == "image" or el.kind == "table" {
          // counting 
          let num = counter(el.kind + "-chapter" + str(chapt)).at(loc).at(0) + 1
          it.element.supplement
          " "
          str(chapt)
          "."
          str(num)
        } else if el.kind == "thmenv" {
          let thms = query(selector(<meta:thmenvcounter>).after(loc), loc)
          let number = thmcounters.at(thms.first().location()).at("latest")
          it.element.supplement
          " "
          numbering(it.element.numbering, ..number)
        } else {
          it
        }
      ]
    } else if it.element != none and it.element.func() == math.equation {
      let el = it.element
      let loc = el.location()
      let chapt = counter(heading).at(loc).at(0)
      let num = counter(math.equation).at(loc).at(0)

      it.element.supplement
      " ("
      str(chapt)
      "."
      str(num)
      ")"
    } else if it.element != none and it.element.func() == heading {
      let el = it.element
      let loc = el.location()
      let num = numbering(el.numbering, ..counter(heading).at(loc))
      if el.level == 1 {
        "第"
        str(num).replace(".", "")
        "章"
      } else if el.level == 2 {
        str(num)
        "節"
      } else if el.level == 3 {
        str(num)
        "項"
      }
    } else {
      it
    }
  }

  set text(font: "Zen Kaku Gothic Antique", weight: "medium")

  // タイトル
  place(top + center, dy: 4.7cm)[
    #box(
      width: 90%,
      outset: 2em,
      [
        #align(center, text(15pt)[
          卒業論文
        ])
        #align(center, text(25pt)[
          #title
        ])
      ]
    )
  ]

  // 著者名
  // 指導教員
  // 年月日
  // 所属
  place(bottom + center, dy: -3.7cm)[
    #box(
      width: 90%,
      outset: 2em,
      [
        #grid(
          columns: (1fr, 1fr),
          
          place(
            right,
            dx: -2em,
            text(16pt)[
              #student_id
            ]
          ),
          place(
            left,
            dx: -1em,
            dy: -0.12em,
            text(18pt)[
              #your_name_jp
            ]
          )
        )
        #v(30pt)
        #grid(
          columns: (1fr, 1fr),
          place(
            right,
            dx: -2em,
            text(16pt)[
              指導教員
            ]
          ),
          place(
            left,
            dx: -1em,
            text(16pt)[
              #mentor_name #mentor_position
            ]
          ),
        )

        
        #v(55pt)
        #align(center, text(16pt)[
          #write_year 年 #write_month 月
        ])
        
        #v(55pt)
        #align(center, text(16pt)[
          東京大学工学部計数工学科システム情報工学コース
        ])
      ]
    )
  ]

  pagebreak()

  // Copyright
  set text(font: "Noto Serif JP", weight: "regular")
  place(
    bottom + left,
    dy: -3.6cm,
    text(10pt)[
      Copyright $copyright$ #write_year #your_name_en
    ]
  )

  pagebreak()

  // Abstract
  v(7.8cm)
  box(
    width: 100%,
  )[
    #align(center)[
      #text(10pt, font: "Zen Kaku Gothic Antique")[
        概要
      ]
    ]
    #v(5pt)
    #set par(first-line-indent: 0pt)
    #align(left)[
      #text(10pt, font: "Noto Serif JP")[
        #abstract
      ]
    ]
  ]
  pagebreak()

  pagebreak()

  // 目次
  v(3.9cm)
  box(
    width: 100%,
  )[
    #show outline: it => {
      let elements = query(it.target)
      set par(first-line-indent: 0pt)
      text(26pt, font: "Zen Kaku Gothic Antique", weight: "bold")[
        #it.title
      ]
      v(2.5em)
      set par(first-line-indent: 0pt)
      set text(10pt, font: "Noto Serif JP", weight: "regular")
      for el in elements {
        // repr(el)
        let level = el.level
        let loc = el.location()
        let page = loc.page() - 5 // offset
        
        if level == 1 {
          v(5pt)
          [
            #if el.numbering != none {
              text(10pt, weight: "bold")[
                #numbering("第1章", ..counter(heading).at(loc))
              ]
            } else {
              text(10pt, weight: "bold")[
                #el.body
              ]
            }
            #box(width: 1fr, repeat[])
            #page 
            \
          ]
        } else if level == 2 {
          [
            #h(10pt)
            #numbering("1.1", ..counter(heading).at(loc))
            #box(width: 0.05fr, repeat(""))
            #box(width: 0.9fr, repeat("  .  "))
            #box(width: 0.05fr, repeat(""))
            #page 
            \ 
          ]
        } // 3以上は無視
      }
    }

    #outline(title: "目次")
  ]

  pagebreak()

  
  // In case you need to right- or left-align the page number, 
  // use the number-align argument of the page set rule. 
  // Alternating alignment between even and odd pages is not 
  // currently supported using this property. 
  // To do this, you'll need to specify a custom footer with 
  // your footnote and query the page counter as described in 
  // the section on conditionally omitting headers and footers.
  // ref. https://typst.app/docs/guides/page-setup-guide/
  counter(page).update(0)
  // Footerを置き換える形で実装する
  // パワープレイな理由は，章を変更した時にページの横に何かがつくのを避けるため
  set page(footer: context {
    let selector = selector(heading.where(level: 1)).before(here())
    let level = counter(selector)
    let headings = query(selector)
    place(
      top,
      dy: -24.45cm
    )[
      #let page_here = counter(page).get().first()
      #let flag = headings.len() == 0
      #if headings.len() > 0 {
        let last_heading = headings.last()
        let last_loc = last_heading.location()
        let last_page = last_loc.page() - 6
        flag = last_page == page_here
      }

      #if calc.even(page_here) [
        #text(9pt, weight: "bold", font: "Noto Serif JP")[
          #counter(page).get().first()
          #h(0.05fr)
          #if not flag {
            numbering("第1章", counter(heading).get().first())
          }
        ]
        #h(1fr)
      ] else [
        #h(1fr)
        #text(9pt, weight: "bold", font: "Noto Serif JP")[
          #if not flag {
            numbering("1.1", ..counter(heading).get().slice(0, 2))
          }
          #h(0.05fr)
          #counter(page).get().first()
        ]
      ]
    ]
  }, numbering: none, margin: (top: 4.3cm, bottom: 2.8cm, left: 3cm, right: 3cm))

  pagebreak()

  body

  // Display bibliography.
  if bibliography-file != "" {
    show bibliography: set text(12pt)
    show bibliography: set heading(numbering: "[1]")
    show bibliography: it => {
      pagebreak()
      heading(level: 1, outlined: true, numbering: none)[参考文献]
      v(1em)
      set text(10pt)
      it
    }
    bibliography(bibliography-file, title: none, style: "ieee")
  }
}


// 見出し無しheading
#let chap(body) = [
  #v(60pt)
  #heading(level: 1, outlined: true, numbering: none)[#body]
  #v(22pt)
]