// ============================================================
// lib.typ — 초석(礎石) 템플릿 컴포넌트
// ============================================================
#import "theme.typ": *
#import "@preview/cetz:0.4.2"

// 도식 번호 카운터
#let figc = counter("figure-diagram")

// ---- 전역 템플릿 ----
#let template(body) = {
  set page(
    paper: "a4",
    margin: page-margin,
    footer: context {
      let n = counter(page).get().first()
      set align(center)
      text(font: font-body, size: 9pt, fill: faint)[— #n —]
    },
  )
  set text(font: font-body, size: body-size, fill: ink, weight: w-reg, lang: "ko", spacing: 100%)
  set par(justify: true, leading: body-leading, spacing: body-spacing, first-line-indent: 0pt)

  // 섹션 제목 (level 1) — 각 섹션을 새 페이지에서 시작
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    block(above: 0.6em, below: 1.1em, breakable: false)[
      #text(font: font-body, size: 8.5pt, weight: w-bold, fill: gold, tracking: 0.18em)[SECTION]
      #v(-0.4em)
      #text(font: font-body, size: 17pt, weight: w-black, fill: ink)[#it.body]
      #v(0.1em)
      #line(length: 2.2cm, stroke: 1.4pt + gold)
    ]
  }
  // 소제목 (level 2)
  show heading.where(level: 2): it => {
    block(above: 1.5em, below: 0.9em, sticky: true)[
      #text(font: font-body, size: 12.5pt, weight: w-bold, fill: ink)[#it.body]
    ]
  }
  // 강조 인라인
  show strong: it => text(weight: w-bold, fill: ink)[#it.body]

  body
}

// ---- 작은 골드 키커 라벨 ----
#let kicker(s) = text(font: font-body, size: 8.5pt, weight: w-bold, fill: gold, tracking: 0.18em)[#upper(s)]

// ---- 풀디자인 표지 (이미지 배경 — 시계 그림자 + 남자 실루엣) ----
#let cover(
  title: "초석",
  hanja: "礎石",
  series: "한조 비기 · THE LEGACY",
  subtitle: "최상위 유혹자의 기본 마인드셋",
  tagline: "",
  badges: (),
) = {
  page(fill: rgb("#080808"), margin: (x: 0pt, y: 0pt), footer: none, header: none)[
    // ─ 전면 배경 이미지 (full bleed)
    #place(top + left, dx: 0pt, dy: 0pt)[
      #image("assets/cover-bg.png", width: 21cm, height: 29.7cm, fit: "cover")
    ]

    // ─ 좌상단 에디션 라벨
    #place(top + left, dx: 2.4cm, dy: 2.3cm)[
      #text(size: 7.5pt, weight: w-med, fill: white.transparentize(35%), tracking: 0.35em)[THE LEGACY · 1부]
    ]
    // ─ 우상단 골드 세로선
    #place(top + right, dx: -2.4cm, dy: 2.3cm)[
      #line(start: (0pt, 0pt), end: (0pt, 2.0cm), stroke: 0.5pt + gold.lighten(20%))
    ]

    // ─ 제목 블록 (이미지 상단 어둠 영역 — 약 3~7cm 구간)
    #place(top + center, dy: 3.0cm)[
      #align(center)[
        #text(size: 88pt, weight: w-black, fill: white, tracking: -0.01em)[#title]
        #v(-0.4em)
        #text(size: 22pt, weight: w-light, fill: gold)[#hanja]
        #v(0.7em)
        #line(length: 2.4cm, stroke: 0.5pt + white.transparentize(55%))
        #v(0.55em)
        #text(size: 9pt, weight: w-reg, fill: white.transparentize(25%), tracking: 0.1em)[#series]
        #v(0.25em)
        #text(size: 8.5pt, weight: w-reg, fill: white.transparentize(45%))[저 · 한조]
      ]
    ]

    // ─ 하단 반투명 띠
    #place(bottom + left, dx: 0pt, dy: 0pt)[
      #block(width: 21cm, fill: rgb("#080808").transparentize(15%), inset: (x: 2.4cm, top: 0.85cm, bottom: 1.0cm))[
        #set text(fill: on-dark, font: font-body)
        #if tagline != "" [
          #text(size: 11pt, weight: w-black, fill: on-dark)[#tagline]
          #v(0.5em)
        ]
        #if badges.len() > 0 {
          grid(columns: badges.len() * (auto,), column-gutter: 1.0cm,
            ..badges.map(b => {
              stack(spacing: 0.18em,
                text(size: 16pt, weight: w-black, fill: gold)[#b.at(0)],
                text(size: 7pt, weight: w-med, fill: on-dark-mute)[#b.at(1)],
              )
            })
          )
        }
      ]
    ]
  ]
}

// ---- 막(Act) 디바이더 (다크 풀페이지) ----
#let act-divider(num: "", roman: "", title: "", desc: "") = {
  page(fill: dark, margin: (x: 2.4cm, y: 3cm), footer: none, header: none)[
    #set text(fill: on-dark, font: font-body)
    #place(horizon)[
      #block(width: 100%)[
        #text(size: 13pt, weight: w-bold, fill: gold, tracking: 0.3em)[#upper(roman)]
        #v(0.3em)
        #text(size: 64pt, weight: w-black, fill: on-dark)[#num#text(size: 30pt)[막]]
        #v(0.2em)
        #text(size: 30pt, weight: w-black, fill: on-dark)[#title]
        #v(0.7em)
        #line(length: 3cm, stroke: 1.4pt + gold)
        #v(0.7em)
        #block(width: 100%)[
          #text(size: 12pt, weight: w-light, fill: on-dark-mute)[#desc]
        ]
      ]
    ]
  ]
}

// ---- 에피그래프 (섹션 도입 인용) ----
#let epigraph(body) = block(width: 100%, above: 0.4em, below: 1.6em, inset: (left: 1em), stroke: (left: 2pt + gold))[
  #text(size: 12.5pt, weight: w-med, fill: muted, style: "italic")[#body]
]

// ---- 매니페스토 (센터드 강조 클로저) ----
#let manifesto(body, accent: gold) = block(width: 100%, above: 1.15em, below: 1.5em, breakable: false)[
  #align(center)[
    #line(length: 1.6cm, stroke: 1pt + accent)
    #v(0.6em)
    #text(size: 15pt, weight: w-black, fill: ink)[#body]
    #v(0.6em)
    #line(length: 1.6cm, stroke: 1pt + accent)
  ]
]

// ---- 콜아웃 박스 (정직선언/반론/정의/체크리스트) ----
// kind: "gold" | "crimson" | "neutral"
#let callout(title: none, body, kind: "gold", icon: none) = {
  let (bg, bd, ac) = if kind == "crimson" {
    (crimson-soft, crimson, crimson)
  } else if kind == "neutral" {
    (paper-soft, rule, ink)
  } else {
    (gold-soft, gold, gold.darken(15%))
  }
  block(width: 100%, above: 1.4em, below: 1.4em, breakable: false,
    fill: bg, radius: 6pt, inset: (x: 1.1em, y: 1em), stroke: (left: 3pt + bd))[
    #if title != none [
      #text(size: 12pt, weight: w-black, fill: ac)[#if icon != none [#icon #h(0.3em)]#title]
      #v(0.5em)
    ]
    #set text(size: 10pt, fill: ink)
    #body
  ]
}

// ---- 24시간 미션 박스 (실행 루프: 행동 전 → 행동 → 행동 후 기록) ----
#let mission(action, before-q, after-q) = block(width: 100%, above: 1.4em, below: 1.4em, breakable: false,
  fill: gold-soft, radius: 6pt, inset: (x: 1.1em, y: 1em), stroke: (left: 3pt + gold))[
  #text(size: 11pt, weight: w-black, fill: gold.darken(15%))[24시간 미션 — 머리로 알았으면, 오늘 안에 몸으로 증명하라]
  #v(0.5em)
  #set text(size: 10pt, fill: ink)
  *오늘 할 행동:* #action
  #v(0.35em)
  *[행동 전 한 문장]* #before-q
  #linebreak()
  *[잠들기 전 한 문장]* #after-q
  #v(0.3em)
  #text(size: 8.5pt, fill: muted)[기록하지 않은 깨달음은 어제와 똑같은 자리로 너를 되돌린다. 한 줄이라도 적어라.]
]

// ---- 막 사이 브릿지 (앞 막을 받아 다음 막으로 넘기는 연결 문장) ----
#let bridge(body) = block(width: 100%, above: 1.6em, below: 1.6em, breakable: false)[
  #align(center)[
    #box(width: 80%)[
      #set text(size: 11.5pt, weight: w-med, fill: muted, style: "italic")
      #set par(justify: false, leading: 0.8em)
      #align(center)[#body]
    ]
  ]
]

// ---- 오퍼 박스 (다음 단계 — 결과/형태/가격/정원/보장) ----
#let offer(name, hanja, result, form, price, limit, guarantee) = block(width: 100%, above: 1em, below: 1em, breakable: false,
  fill: paper-soft, radius: 6pt, inset: (x: 1em, y: 0.85em), stroke: (left: 3pt + gold))[
  #text(size: 12pt, weight: w-black, fill: ink)[#name #text(fill: gold, size: 10pt)[#hanja]]
  #v(0.4em)
  #set text(size: 9.5pt, fill: ink)
  *얻는 것* — #result \
  *형태* — #form \
  *가격* — #price \
  *정원·기간* — #limit \
  *보장* — #guarantee
]

// ---- 용어풀이박스 (인라인 정의) ----
#let glossary(term, def) = block(width: 100%, above: 1em, below: 1em, breakable: false,
  fill: paper-soft, radius: 5pt, inset: (x: 0.9em, y: 0.7em), stroke: (left: 2.5pt + gold))[
  #text(size: 10pt, weight: w-black, fill: gold.darken(12%))[#term]
  #text(size: 9.5pt, fill: muted)[ — #def]
]

// ---- 리드 / 덱 (제목 바로 아래 한 줄 부제) ----
#let lead(body) = block(width: 100%, above: 0.1em, below: 1.3em)[
  #set par(leading: 0.72em)
  #text(size: 12.5pt, weight: w-semi, fill: ink.lighten(6%))[#body]
]

// ---- before/after 2칼럼 대비 ----
#let before-after(left-title: "이전", right-title: "이후", bad, good) = block(above: 1.4em, below: 1.4em, breakable: false)[
  #grid(columns: (1fr, 1fr), column-gutter: 0.8em,
    block(fill: crimson-soft, radius: 6pt, inset: 0.9em, width: 100%)[
      #text(size: 10.5pt, weight: w-black, fill: crimson)[✕ #left-title]
      #v(0.4em)
      #text(size: 9.5pt)[#bad]
    ],
    block(fill: gold-soft, radius: 6pt, inset: 0.9em, width: 100%)[
      #text(size: 10.5pt, weight: w-black, fill: gold.darken(15%))[○ #right-title]
      #v(0.4em)
      #text(size: 9.5pt)[#good]
    ],
  )
]

// ---- 도식 프레임 (cetz/fletcher 공통 래퍼) ----
#let diagram-frame(body, caption: none) = {
  figc.step()
  block(width: 100%, above: 1.5em, below: 1.5em, breakable: false)[
    #align(center)[
      #body
      #if caption != none [
        #v(0.5em)
        #text(size: 9pt, fill: muted)[#text(weight: w-bold, fill: gold.darken(10%))[도식 #context figc.display()] · #caption]
      ]
    ]
  ]
}

// ---- 갤러리 (카톡 후기 등 다수 캡처 그리드, 페이지 넘김 가능) ----
#let gallery(paths, cols: 3, title: none, note: none) = {
  if title != none {
    // sticky: 제목이 페이지 맨 아래 홀로 남지 않고 첫 행과 함께 넘어가도록
    block(above: 1.3em, below: 0.7em, breakable: false, sticky: true)[
      #kicker("Real Proof")
      #v(0.15em)
      #text(size: 15pt, weight: w-black, fill: ink)[#title]
      #if note != none [ #linebreak() #text(size: 9pt, fill: muted)[#note] ]
    ]
  }
  let n = paths.len()
  let i = 0
  while i < n {
    let row = paths.slice(i, calc.min(i + cols, n))
    let cells = row.map(p => box(width: 100%, radius: 4pt, clip: true, stroke: 0.5pt + rule)[#image(p, width: 100%)])
    // 마지막 부분 행은 셀 폭을 유지한 채 가운데 정렬(빈 셀 패딩)
    if cells.len() < cols {
      let pad = cols - cells.len()
      let lead = calc.floor(pad / 2)
      cells = range(lead).map(_ => []) + cells + range(pad - lead).map(_ => [])
    }
    block(breakable: false, below: 0.55em)[
      #grid(columns: cols * (1fr,), column-gutter: 0.5em, align: top + center, ..cells)
    ]
    i = i + cols
  }
}

// ---- 이미지 figure ----
#let figure-img(path, caption: none, width: 80%) = block(width: 100%, above: 1.4em, below: 1.4em, breakable: false)[
  #align(center)[
    #box(radius: 4pt, clip: true, stroke: 0.5pt + rule)[#image(path, width: width)]
    #if caption != none [
      #v(0.4em)
      #text(size: 9pt, fill: muted)[#caption]
    ]
  ]
]

// ---- 증거 월 (Wall of Proof) ----
// featured: 대표 후기 1장(경로), thumbs: 보조 캡처 경로 배열
#let proof-wall(featured: none, featured-cap: "", thumbs: (), thumb-caps: ()) = {
  // 헤더 + featured 를 한 블록으로 묶어 분리(고아 페이지) 방지
  block(above: 1.2em, below: 1.2em, breakable: false)[
    #kicker("Real Proof")
    #v(0.2em)
    #text(size: 16pt, weight: w-black, fill: ink)[실제로 일어나는 일들]
    #v(0.2em)
    #text(size: 9.5pt, fill: muted)[수강생 후기와 교제 기록 일부. 의심된다면, 직접 찾아오라.]
    #if featured != none [
      #v(0.7em)
      #align(center)[
        #box(radius: 6pt, clip: true, stroke: 0.5pt + rule)[#image(featured, width: 8cm)]
        #if featured-cap != "" [ #v(0.3em) #text(size: 8.5pt, fill: muted)[#featured-cap] ]
      ]
    ]
  ]
  if thumbs.len() > 0 {
    block(breakable: false)[
      #grid(columns: thumbs.len() * (1fr,), column-gutter: 0.6em,
        ..thumbs.enumerate().map(((i, t)) => {
          align(center + top)[
            #box(radius: 5pt, clip: true, stroke: 0.5pt + rule)[#image(t, width: 100%)]
            #if i < thumb-caps.len() and thumb-caps.at(i) != "" [
              #v(0.2em) #text(size: 7.5pt, fill: muted)[#thumb-caps.at(i)]
            ]
          ]
        })
      )
    ]
  }
}

// ---- 비주얼 목차 (5막) ----
#let toc-visual(acts) = {
  block(above: 1em)[
    #kicker("Contents")
    #v(0.2em)
    #text(size: 24pt, weight: w-black, fill: ink)[여정의 지도]
    #v(1em)
    #for (i, a) in acts.enumerate() [
      #block(below: 0.9em, breakable: false)[
        #grid(columns: (auto, 1fr), column-gutter: 0.9em, align: (top, top),
          box(fill: dark, radius: 4pt, inset: (x: 0.55em, y: 0.4em))[
            #text(fill: gold, weight: w-black, size: 12pt)[#a.at(0)막]
          ],
          [
            #text(size: 13pt, weight: w-black, fill: ink)[#a.at(1)]
            #v(-0.3em)
            #text(size: 9.5pt, fill: muted)[#a.at(2)]
          ],
        )
      ]
    ]
  ]
}
