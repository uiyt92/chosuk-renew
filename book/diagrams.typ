// ============================================================
// diagrams.typ — 초석 개념 도식 (cetz / cetz-plot / fletcher)
// 각 함수는 캔버스(content)를 반환. 호출부에서 diagram-frame으로 감싼다.
// ============================================================
#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.3": plot
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "theme.typ": *

#import cetz.draw: *

// 공통 폰트(캔버스 내부 content는 set text 영향을 받으므로 명시)
#let dfont = font-body

// ─────────────────────────────────────────────
// [1순위-1] 3부작 위계 피라미드  (초석·초인·초살)
// ─────────────────────────────────────────────
#let dia-pyramid() = cetz.canvas(length: 1cm, {
  let trap(y0, y1, wb, wt, fill, stroke: none) = {
    line((-wb/2, y0), (wb/2, y0), (wt/2, y1), (-wt/2, y1), close: true, fill: fill, stroke: stroke)
  }
  // 위→아래: 초살(top) / 초인(mid) / 초석(base, 강조)
  trap(2.7, 3.9, 3.4, 1.4, dark)        // 초살
  trap(1.4, 2.6, 5.6, 3.6, dark2)       // 초인
  trap(0.0, 1.3, 8.0, 5.8, gold)        // 초석 (base)
  // 라벨
  content((0, 3.25), text(font: dfont, fill: on-dark, weight: "bold", size: 11pt)[초살 秒殺])
  content((0, 2.0),  text(font: dfont, fill: on-dark, weight: "bold", size: 12pt)[초인 招人])
  content((0, 0.78), text(font: dfont, fill: dark, weight: "black", size: 15pt)[초석 礎石])
  content((0, 0.28), text(font: dfont, fill: dark, weight: "medium", size: 8.5pt)[기본 마인드 · 지금 여기 · 무료])
  // 오른쪽 한 줄 정의
  content((4.6, 3.25), anchor: "west", text(font: dfont, fill: muted, size: 8.5pt)[금단의 방중술])
  content((4.6, 2.0),  anchor: "west", text(font: dfont, fill: muted, size: 8.5pt)[관계를 끌어당기는 기술])
  content((4.6, 0.65), anchor: "west", text(font: dfont, fill: gold.darken(20%), size: 8.5pt, weight: "bold")[모든 것을 떠받치는 토대])
  // 좌측 화살표(위로 쌓인다)
  line((-4.8, 0), (-4.8, 3.9), stroke: 1pt + muted, mark: (end: ">"))
  content((-5.0, 1.95), anchor: "east", angle: 90deg, text(font: dfont, fill: muted, size: 8pt)[쌓아 올린다])
})

// ─────────────────────────────────────────────
// [1순위-2] 세 부류의 남자 3계단 (NPC→모방자→슈퍼내츄럴)
// ─────────────────────────────────────────────
#let dia-three-tier() = cetz.canvas(length: 1cm, {
  let step(x0, h, fill, tcol, title, sub, reac) = {
    rect((x0, 0), (x0 + 3.0, h), fill: fill, stroke: none, radius: 0.12)
    content((x0 + 1.5, h - 0.5), text(font: dfont, fill: tcol, weight: "black", size: 12pt)[#title])
    content((x0 + 1.5, h - 1.05), text(font: dfont, fill: tcol, size: 7.5pt)[#sub])
    content((x0 + 1.5, 0.42), text(font: dfont, fill: tcol, size: 7.5pt, style: "italic")[#reac])
  }
  step(0.0, 2.2, paper-soft, ink, "NPC", "정체성 없는 배경 캐릭터", "여자: 무관심")
  step(3.4, 3.1, dark2, on-dark, "모방자", "멘트만 외운 자", "여자: 본능적 거절")
  step(6.8, 4.0, gold, dark, "슈퍼내츄럴", "존재가 곧 매력", "여자: 자발적 끌림")
  // 상승 화살표
  line((0.2, 4.2), (9.6, 4.2), stroke: 1.4pt + gold, mark: (end: ">"))
  content((4.9, 4.55), text(font: dfont, fill: gold.darken(15%), weight: "bold", size: 8.5pt)[이 문서가 데려갈 방향])
})

// ─────────────────────────────────────────────
// [1순위-3] 본심 빙산 (오버소울)
// ─────────────────────────────────────────────
#let dia-iceberg() = cetz.canvas(length: 1cm, {
  // 수면
  let wl = 2.6
  rect((-5.2, wl), (5.2, wl + 1.9), fill: rgb("#DCE7EE"), stroke: none) // 수면 위 하늘톤
  rect((-5.2, wl - 4.0), (5.2, wl), fill: rgb("#AFC4D2"), stroke: none) // 수면 아래 물톤
  // 빙산 위 (작음)
  line((0, wl + 1.7), (-1.3, wl), (1.3, wl), close: true, fill: on-dark, stroke: none)
  // 빙산 아래 (큼)
  line((-1.3, wl), (1.3, wl), (2.7, wl - 2.0), (1.2, wl - 3.6), (-1.2, wl - 3.6), (-2.7, wl - 2.0), close: true, fill: rgb("#7C93A4"), stroke: none)
  // 수면선
  line((-5.2, wl), (5.2, wl), stroke: (paint: white, thickness: 1.5pt, dash: "dashed"))
  // 라벨
  content((0, wl + 1.15), text(font: dfont, fill: dark, weight: "bold", size: 8pt)[보이는 나])
  content((3.0, wl + 0.9), anchor: "west", text(font: dfont, fill: muted, size: 8pt)[타인이 설계한 나\ (대학·취업·결혼·좋은사람 코스프레)])
  content((3.0, wl - 0.35), anchor: "west", text(font: dfont, fill: crimson, size: 7.5pt, weight: "bold")[← 여기서부터 여자는 못 느낀다])
  content((0, wl - 1.9), text(font: dfont, fill: white, weight: "black", size: 12pt)[본심 · OVERSOUL])
  content((0, wl - 2.7), text(font: dfont, fill: white, size: 7.5pt)[영혼의 영혼, 진짜 나])
  // 네 기둥(선언)
  let pil = ("인정욕구 버리기", "방어기제 내려놓기", "기대·보상 버리기", "유일무이 사랑하기")
  for (i, p) in pil.enumerate() {
    let x = -3.9 + i * 2.6
    rect((x, wl - 4.9), (x + 2.2, wl - 4.2), fill: gold, stroke: none, radius: 0.08)
    content((x + 1.1, wl - 4.55), text(font: dfont, fill: dark, size: 6.5pt, weight: "bold")[#p])
  }
  content((0, wl - 5.4), text(font: dfont, fill: muted, size: 7.5pt)[본심을 떠받치는 네 개의 선언])
})

// ─────────────────────────────────────────────
// [1순위-4] 스테이트 감정 동조 파동
// ─────────────────────────────────────────────
#let dia-state-wave() = cetz.canvas(length: 1cm, {
  // 유쾌(매끈) 위 / 짜증(찌그러짐) 아래
  let smooth(y0) = {
    let pts = ()
    for i in range(0, 49) {
      let x = i / 6
      pts.push((x, y0 + 0.5 * calc.sin(x * 1.6)))
    }
    line(..pts, stroke: 1.6pt + gold)
  }
  let jagged(y0) = {
    let pts = ()
    for i in range(0, 49) {
      let x = i / 6
      let v = calc.sin(x * 3.1) * calc.sin(x * 1.3)
      pts.push((x, y0 + 0.45 * v))
    }
    line(..pts, stroke: 1.6pt + crimson)
  }
  // 위: 유쾌
  content((-0.4, 3.0), anchor: "east", text(font: dfont, size: 8pt, weight: "bold", fill: gold.darken(15%))[유쾌한 상태])
  content((-0.4, 2.55), anchor: "east", text(font: dfont, size: 7pt, fill: muted)["안녕하세요"])
  smooth(3.0)
  // 아래: 짜증
  content((-0.4, 0.6), anchor: "east", text(font: dfont, size: 8pt, weight: "bold", fill: crimson)[짜증난 상태])
  content((-0.4, 0.15), anchor: "east", text(font: dfont, size: 7pt, fill: muted)["안녕하세요"])
  jagged(0.6)
  // 여자(수신) 원
  circle((8.7, 1.8), radius: 0.6, fill: dark, stroke: none)
  content((8.7, 1.8), text(font: dfont, fill: on-dark, size: 7pt)[여자])
  // 발신 방향 화살표
  line((8.0, 3.0), (8.25, 2.2), stroke: 1pt + gold, mark: (end: ">"))
  line((8.0, 0.6), (8.25, 1.4), stroke: 1pt + crimson, mark: (end: ">"))
  content((8.9, 3.0), anchor: "west", text(font: dfont, size: 7pt, fill: gold.darken(15%))[설렘])
  content((8.9, 0.6), anchor: "west", text(font: dfont, size: 7pt, fill: crimson)[무반응])
  content((4, -0.5), text(font: dfont, size: 7.5pt, fill: muted)[같은 말도, 감정의 진동수가 다르면 다르게 전달된다])
})

// ─────────────────────────────────────────────
// [1순위-5] 엔트로피 高 vs 低 (2열 인물 대조)
// ─────────────────────────────────────────────
#let dia-entropy() = cetz.canvas(length: 1cm, {
  // 좌: 高엔트로피(무질서) — 흩어진 사각
  let scatter = ((0.3,0.4),(1.1,1.7),(0.6,2.6),(1.8,0.9),(0.2,3.4),(1.5,3.0),(0.9,1.0),(2.0,2.2),(0.4,1.9),(1.7,3.6))
  rect((-0.2, 0), (3.2, 4.2), fill: crimson-soft, stroke: none, radius: 0.12)
  for p in scatter {
    rect((p.at(0), p.at(1)), (p.at(0)+0.32, p.at(1)+0.32), fill: crimson, stroke: none, rotate: 0deg)
  }
  content((1.5, -0.45), text(font: dfont, fill: crimson, weight: "black", size: 9pt)[高 엔트로피 = 매력 ✕])
  // 우: 低엔트로피(질서) — 정렬된 사각
  rect((4.8, 0), (8.2, 4.2), fill: gold-soft, stroke: none, radius: 0.12)
  for r in range(0, 4) {
    for c in range(0, 3) {
      let x = 5.2 + c * 0.85
      let y = 0.5 + r * 0.95
      rect((x, y), (x + 0.34, y + 0.34), fill: gold.darken(8%), stroke: none)
    }
  }
  content((6.5, -0.45), text(font: dfont, fill: gold.darken(18%), weight: "black", size: 9pt)[低 엔트로피 = 매력 ○])
  // 행동 대조 라벨 (상단)
  content((1.5, 4.6), text(font: dfont, fill: crimson, size: 7pt)[어깨 처짐 · 중언부언 · 감정 다 티 냄])
  content((6.5, 4.6), text(font: dfont, fill: gold.darken(18%), size: 7pt)[반듯한 자세 · 정제된 말 · 한 박자 늦게])
  // 중앙 대비 기호
  content((4.0, 2.1), text(font: dfont, fill: muted, weight: "black", size: 14pt)[vs])
})

// ─────────────────────────────────────────────
// [2순위-1] 어둠의 삼원 벤다이어그램 (+인격적 성숙 받침)
// ─────────────────────────────────────────────
#let dia-darktriad() = cetz.canvas(length: 1cm, {
  rect((-4.6, -4.8), (4.6, -4.0), fill: gold, stroke: none, radius: 0.1)
  content((0, -4.4), text(font: dfont, fill: dark, weight: "bold", size: 8.5pt)[받침: 인격적 성숙 (초석 마인드) — 이게 없으면 그냥 나쁜 놈])
  circle((-1.5, 0.9), radius: 2.3, fill: crimson.transparentize(72%), stroke: 1pt + crimson)
  circle((1.5, 0.9), radius: 2.3, fill: gold.transparentize(72%), stroke: 1pt + gold.darken(10%))
  circle((0, -1.4), radius: 2.3, fill: dark.transparentize(80%), stroke: 1pt + dark)
  content((-3.2, 2.5), text(font: dfont, fill: crimson, weight: "bold", size: 9pt)[M 마키아벨리즘])
  content((-2.2, 2.0), text(font: dfont, fill: muted, size: 6.5pt)[상황을 리드하는 책략])
  content((3.2, 2.5), text(font: dfont, fill: gold.darken(15%), weight: "bold", size: 9pt)[N 나르시시즘])
  content((3.2, 2.0), text(font: dfont, fill: muted, size: 6.5pt)[조건 없는 자기확신])
  content((0, -2.45), text(font: dfont, fill: dark, weight: "bold", size: 9pt)[P 사이코패시])
  content((0, -2.85), text(font: dfont, fill: muted, size: 6.5pt)[자기 기준에 대한 냉정한 신뢰])
  content((0, 0.3), text(font: dfont, fill: ink, weight: "black", size: 11pt)[정체성])
})

// ─────────────────────────────────────────────
// [2순위-2] MPO Y자 분기 (생각·행동의 근원)
// ─────────────────────────────────────────────
#let dia-mpo() = cetz.canvas(length: 1cm, {
  rect((-3.2, 4.4), (3.2, 5.3), fill: dark, stroke: none, radius: 0.1)
  content((0, 4.85), text(font: dfont, fill: on-dark, weight: "bold", size: 8.5pt)[동일 입력: 좋은 학교 · 직업 · 차 · 외모])
  line((-1.0, 4.4), (-3.4, 3.5), stroke: 1.2pt + crimson, mark: (end: ">"))
  line((1.0, 4.4), (3.4, 3.5), stroke: 1.2pt + gold.darken(10%), mark: (end: ">"))
  let lx = -3.4
  rect((lx - 2.0, 2.5), (lx + 2.0, 3.3), fill: crimson-soft, stroke: 1.2pt + crimson, radius: 0.08)
  content((lx, 2.9), text(font: dfont, fill: crimson, weight: "bold", size: 8.5pt)[근원 = 여자])
  line((lx, 2.5), (lx, 1.8), stroke: 1pt + crimson, mark: (end: ">"))
  content((lx, 1.45), text(font: dfont, fill: ink, size: 7.5pt)[투자자 마인드])
  line((lx, 1.1), (lx, 0.4), stroke: 1pt + crimson, mark: (end: ">"))
  rect((lx - 2.1, -0.7), (lx + 2.1, 0.1), fill: crimson, stroke: none, radius: 0.08)
  content((lx, -0.3), text(font: dfont, fill: white, weight: "bold", size: 8pt)[✕ 거절 시 좌절·주도권 상실])
  let rx = 3.4
  rect((rx - 2.0, 2.5), (rx + 2.0, 3.3), fill: gold-soft, stroke: 1.2pt + gold.darken(10%), radius: 0.08)
  content((rx, 2.9), text(font: dfont, fill: gold.darken(18%), weight: "bold", size: 8.5pt)[근원 = 나])
  line((rx, 2.5), (rx, 1.8), stroke: 1pt + gold.darken(10%), mark: (end: ">"))
  content((rx, 1.45), text(font: dfont, fill: ink, size: 7.5pt)[성장 마인드])
  line((rx, 1.1), (rx, 0.4), stroke: 1pt + gold.darken(10%), mark: (end: ">"))
  rect((rx - 2.1, -0.7), (rx + 2.1, 0.1), fill: gold, stroke: none, radius: 0.08)
  content((rx, -0.3), text(font: dfont, fill: dark, weight: "bold", size: 8pt)[○ 거절에도 중심 유지])
  content((0, -1.4), text(font: dfont, fill: muted, size: 8pt, weight: "bold")[스펙은 같다. 근원(MPO)만 다르다 — 그 한 끗이 전부를 가른다])
})

// ─────────────────────────────────────────────
// [2순위-3] 행복 선후관계 역전 (결핍 vs 충만)
// ─────────────────────────────────────────────
#let dia-happiness-loop() = cetz.canvas(length: 1cm, {
  let bx(x, y, w, fill, tcol, body) = {
    rect((x - w/2, y - 0.45), (x + w/2, y + 0.45), fill: fill, stroke: none, radius: 0.1)
    content((x, y), text(font: dfont, fill: tcol, weight: "bold", size: 8pt)[#body])
  }
  content((-4.8, 2.7), anchor: "west", text(font: dfont, fill: crimson, weight: "black", size: 8.5pt)[✕ 끝없는 순환])
  bx(-2.8, 1.8, 2.0, crimson-soft, crimson, "결핍")
  line((-1.8, 1.8), (-0.8, 1.8), stroke: 1pt + crimson, mark: (end: ">"))
  bx(0.9, 1.8, 2.8, crimson-soft, crimson, "연애로 채우려 함")
  line((2.3, 1.8), (3.3, 1.8), stroke: 1pt + crimson, mark: (end: ">"))
  bx(4.5, 1.8, 2.0, crimson, white, "더 큰 결핍")
  bezier((4.5, 2.25), (-2.8, 2.25), (4.5, 3.5), (-2.8, 3.5), stroke: 1pt + crimson, mark: (end: ">"))
  content((-4.8, 0.0), anchor: "west", text(font: dfont, fill: gold.darken(15%), weight: "black", size: 8.5pt)[○ 일방향])
  bx(-2.2, -0.8, 3.0, gold-soft, gold.darken(18%), "자기 충만 (SELF)")
  line((-0.7, -0.8), (1.1, -0.8), stroke: 1.2pt + gold.darken(10%), mark: (end: ">"))
  bx(3.1, -0.8, 2.6, gold, dark, "여자가 끌린다")
  content((0, -1.9), text(font: dfont, fill: muted, size: 8pt)[행복이 먼저다. 연애로 결핍을 채우려 하면 더 큰 결핍이 돌아온다])
})

// ─────────────────────────────────────────────
// [2순위-4] ONEITIS 하강 계단
// ─────────────────────────────────────────────
#let dia-oneitis-stairs() = cetz.canvas(length: 1cm, {
  let steps = (
    ("ONEITIS 발동", "그녀가 유일하다"),
    ("감지", "나에게 다 걸었구나"),
    ("판단", "리드를 못 받겠다"),
    ("무시 시작", "끌림이 식는다"),
    ("프레임 종속", "끌려다닌다"),
    ("떼쓰기", "관계 붕괴"),
  )
  for (i, s) in steps.enumerate() {
    let x = i * 1.75
    let y = 4.5 - i * 0.95
    rect((x, y), (x + 2.5, y + 0.85), fill: crimson.lighten(i * 5%), stroke: none, radius: 0.08)
    content((x + 1.25, y + 0.56), text(font: dfont, fill: white, weight: "bold", size: 8pt)[#s.at(0)])
    content((x + 1.25, y + 0.24), text(font: dfont, fill: rgb("#F6E0E0"), size: 6.8pt)[#s.at(1)])
    if i < steps.len() - 1 {
      line((x + 2.5, y + 0.1), (x + 1.75, y - 0.1), stroke: 1pt + crimson, mark: (end: ">"))
    }
  }
  content((5.4, -1.1), text(font: dfont, fill: muted, size: 7.5pt, style: "italic")[한 명에게 다 걸수록, 추락은 가팔라진다])
})

// ─────────────────────────────────────────────
// [2순위-5] 성공 기준 2x2 매트릭스 (과정 × 결과)
// ─────────────────────────────────────────────
#let dia-success-2x2() = cetz.canvas(length: 1cm, {
  let s = 3.2
  rect((0, s), (s, 2*s), fill: crimson, stroke: white + 2pt)
  rect((s, s), (2*s, 2*s), fill: gold, stroke: white + 2pt)
  rect((0, 0), (s, s), fill: paper-soft, stroke: white + 2pt)
  rect((s, 0), (2*s, s), fill: gold-soft, stroke: white + 2pt)
  content((s/2, 1.5*s), text(font: dfont, fill: white, weight: "black", size: 9pt)[✕ 최악])
  content((s/2, 1.5*s - 0.5), text(font: dfont, fill: rgb("#F2DADA"), size: 6.5pt)[찐따였는데 넘어옴])
  content((1.5*s, 1.5*s), text(font: dfont, fill: dark, weight: "black", size: 9pt)[더블 윈])
  content((s/2, s/2), text(font: dfont, fill: muted, size: 8pt)[당연한 실패])
  content((1.5*s, s/2 + 0.25), text(font: dfont, fill: gold.darken(20%), weight: "black", size: 9pt)[○ 성공])
  content((1.5*s, s/2 - 0.3), text(font: dfont, fill: muted, size: 6.5pt)[최고였는데 거절당함])
  line((0, -0.1), (2*s, -0.1), stroke: 1pt + ink, mark: (end: ">"))
  content((0, -0.6), anchor: "west", text(font: dfont, fill: ink, size: 7.5pt)[찐따])
  content((2*s, -0.6), anchor: "east", text(font: dfont, fill: ink, size: 7.5pt)[최고의 나])
  content((s, -1.0), text(font: dfont, fill: muted, size: 7pt, weight: "bold")[과정 →])
  line((-0.1, 0), (-0.1, 2*s), stroke: 1pt + ink, mark: (end: ">"))
  content((-0.55, 0), anchor: "south", angle: 90deg, text(font: dfont, fill: ink, size: 7.5pt)[거절])
  content((-0.55, 2*s), anchor: "north", angle: 90deg, text(font: dfont, fill: ink, size: 7.5pt)[YES])
  content((2*s + 0.3, 1.5*s), anchor: "west", text(font: dfont, fill: crimson, size: 7pt, weight: "bold")[← 결과축은\ 채점 기준이\ 아니다])
})

// ─────────────────────────────────────────────
// [3순위-1] know-do gap 절벽
// ─────────────────────────────────────────────
#let dia-knowdo() = cetz.canvas(length: 1cm, {
  rect((-5.0, 0), (-1.3, 2.2), fill: dark2, stroke: none)
  content((-3.15, 1.5), text(font: dfont, fill: on-dark, weight: "bold", size: 9pt)[머리로 앎])
  content((-3.15, 0.95), text(font: dfont, fill: on-dark-mute, size: 6.5pt)[명시적 지식\ 가슴은 뛰나 행동은 그대로])
  rect((1.3, 0), (5.0, 2.2), fill: gold, stroke: none)
  content((3.15, 1.5), text(font: dfont, fill: dark, weight: "bold", size: 9pt)[몸에 밴 앎])
  content((3.15, 0.95), text(font: dfont, fill: dark, size: 6.5pt)[암묵적 지식\ 무의식이 실행한다])
  rect((-1.3, 1.9), (1.3, 2.2), fill: gold.darken(10%), stroke: none)
  content((0, 2.55), text(font: dfont, fill: gold.darken(18%), weight: "bold", size: 8pt)[다리: 매뉴얼 + 반복 실천])
  content((0, 0.95), text(font: dfont, fill: crimson, weight: "bold", size: 8.5pt)[know-do gap])
  line((0, 1.7), (0, -0.6), stroke: (paint: muted, thickness: 1pt, dash: "dashed"), mark: (end: ">"))
  content((0, -1.0), text(font: dfont, fill: muted, size: 7pt)[멈추면 → '성공학 포르노'로 추락])
})

// ─────────────────────────────────────────────
// [3순위-2] THE LEGACY 3부작 퍼널/로드맵
// ─────────────────────────────────────────────
#let dia-funnel() = cetz.canvas(length: 1cm, {
  let stages = (
    ("초석 礎石", "기반 마인드", gold, dark, true),
    ("초인 招人", "존재감·유혹력", dark2, on-dark, false),
    ("초살 秒殺", "금단 방중술", dark2, on-dark, false),
    ("세계관 초대", "여자를 내 세계로", dark, on-dark, false),
  )
  for (i, s) in stages.enumerate() {
    let x = i * 3.0
    rect((x, 0), (x + 2.6, 1.6), fill: s.at(2), stroke: none, radius: 0.12)
    content((x + 1.3, 1.05), text(font: dfont, fill: s.at(3), weight: "black", size: 9.5pt)[#s.at(0)])
    content((x + 1.3, 0.5), text(font: dfont, fill: s.at(3), size: 7pt)[#s.at(1)])
    if s.at(4) {
      content((x + 1.3, 2.15), text(font: dfont, fill: gold.darken(18%), weight: "bold", size: 8pt)[▼ 당신은 지금 여기])
    }
    if i < stages.len() - 1 {
      line((x + 2.6, 0.8), (x + 3.0, 0.8), stroke: 1.4pt + muted, mark: (end: ">"))
    }
  }
})

// ─────────────────────────────────────────────
// [3순위-3] 실존 공식 — 간극을 잇는 다리
// ─────────────────────────────────────────────
#let dia-existential() = cetz.canvas(length: 1cm, {
  rect((-5.0, 0), (-1.5, 1.2), fill: dark2, stroke: none)
  content((-3.25, 0.65), text(font: dfont, fill: on-dark, weight: "bold", size: 8.5pt)[현실 (無)])
  content((-3.25, 0.2), text(font: dfont, fill: on-dark-mute, size: 6.5pt)[지금 가진 것])
  rect((1.5, 0), (5.0, 2.6), fill: gold, stroke: none)
  content((3.25, 1.95), text(font: dfont, fill: dark, weight: "bold", size: 8.5pt)[이상 (有)])
  content((3.25, 1.5), text(font: dfont, fill: dark, size: 6.5pt)[되고 싶은 나])
  line((-1.5, 1.2), (1.5, 2.6), stroke: 2.5pt + gold.darken(10%))
  content((0, 2.4), text(font: dfont, fill: gold.darken(18%), weight: "bold", size: 8pt)[다리: 의미 부여])
  circle((-0.3, 1.95), radius: 0.18, fill: ink, stroke: none)
  content((0, -0.6), text(font: dfont, fill: muted, size: 7.5pt)[간극은 결핍이 아니라, 의미를 부여할 공간이다])
})

// ─────────────────────────────────────────────
// [3순위-4] 소금물 갈증 하강 나선
// ─────────────────────────────────────────────
#let dia-saltwater() = cetz.canvas(length: 1cm, {
  let stages = (
    ("쾌락·물질에 빠짐", 4.5, 8.0),
    ("돈·섹스를 추격", 3.0, 6.2),
    ("끝없는 갈증 (소금물)", 1.5, 4.4),
    ("허무 — 텅 빈 눈", 0.0, 2.6),
  )
  for (i, s) in stages.enumerate() {
    let y0 = s.at(1)
    let w = s.at(2)
    let y1 = y0 + 1.2
    let wt = if i < stages.len() - 1 { stages.at(i + 1).at(2) } else { 1.8 }
    line((-w/2, y1), (w/2, y1), (wt/2, y0), (-wt/2, y0), close: true, fill: crimson.lighten(i * 18%), stroke: none)
    content((0, y0 + 0.55), text(font: dfont, fill: if i < 2 {white} else {crimson.darken(10%)}, weight: "bold", size: 8.5pt)[#s.at(0)])
  }
  line((4.6, 5.1), (4.6, 0.6), stroke: 1pt + muted, mark: (end: ">"))
  content((4.9, 2.8), anchor: "west", text(font: dfont, fill: muted, size: 7pt)[화려함\ →\ 공허])
})

// ─────────────────────────────────────────────
// [should] 슈퍼내츄럴 4기둥 (신전)
// ─────────────────────────────────────────────
#let dia-four-pillars() = cetz.canvas(length: 1cm, {
  // 상단 결과
  content((0, 5.0), text(font: dfont, fill: gold.darken(15%), weight: "bold", size: 9pt)[↑ 여자가 자발적으로 달려온다])
  // 린텔
  rect((-4.3, 3.9), (4.3, 4.6), fill: dark, stroke: none, radius: 0.08)
  content((0, 4.25), text(font: dfont, fill: gold, weight: "black", size: 11pt)[슈퍼내츄럴])
  // 4기둥
  let pil = ("단단한 자아", "자신만의 서사", "고통을 에너지로", "흔들리지 않는 중심")
  for (i, p) in pil.enumerate() {
    let x = -3.3 + i * 2.2
    rect((x - 0.55, 0.4), (x + 0.55, 3.85), fill: gold.transparentize(15%), stroke: none)
    content((x, 2.1), angle: 90deg, text(font: dfont, fill: dark, weight: "bold", size: 8pt)[#p])
  }
  // 바닥
  rect((-4.3, 0), (4.3, 0.4), fill: dark2, stroke: none)
  // 차단: 외모·돈·집안
  content((5.0, 2.0), anchor: "west", text(font: dfont, fill: crimson, size: 7.5pt, weight: "bold")[✕ 외모·돈·집안은\ 기둥이 아니다])
})

// ─────────────────────────────────────────────
// [should] 정체성 베이스 vs 기술 토핑 (2패널)
// ─────────────────────────────────────────────
#let dia-base-topping() = cetz.canvas(length: 1cm, {
  // 좌(o)
  rect((-5.0, 0), (-1.0, 1.4), fill: dark, stroke: none)
  content((-3.0, 0.7), text(font: dfont, fill: gold, weight: "bold", size: 9pt)[정체성 (베이스)])
  rect((-5.0, 1.4), (-1.0, 2.0), fill: gold, stroke: none)
  content((-3.0, 1.7), text(font: dfont, fill: dark, weight: "bold", size: 7.5pt)[기술·멘트])
  content((-3.0, 2.4), text(font: dfont, fill: gold.darken(15%), weight: "black", size: 9pt)[○ 안정])
  // 우(x)
  rect((1.0, 0), (5.0, 1.4), fill: none, stroke: (paint: muted, thickness: 1pt, dash: "dashed"))
  content((3.0, 0.7), text(font: dfont, fill: muted, size: 8pt)[정체성 없음])
  // 흩어진 기술 조각
  for p in ((1.6, 2.6), (2.7, 2.3), (3.9, 2.7), (4.4, 2.1), (3.2, 1.9)) {
    rect((p.at(0), p.at(1)), (p.at(0)+0.5, p.at(1)+0.28), fill: muted.lighten(30%), stroke: none)
  }
  content((3.0, 2.4), text(font: dfont, fill: crimson, weight: "black", size: 9pt)[✕ 공중분해])
  // 화살표 변주
  content((0, -0.7), text(font: dfont, fill: ink, size: 7.5pt)[말→태도 · 행동→에너지 · 스킬→정체성])
})

// ─────────────────────────────────────────────
// [should] 확신의 언어 — 알파/베타 방향
// ─────────────────────────────────────────────
#let dia-alpha-beta() = cetz.canvas(length: 1cm, {
  let bx(x, y, w, fill, tcol, body) = {
    rect((x - w/2, y - 0.45), (x + w/2, y + 0.45), fill: fill, stroke: none, radius: 0.1)
    content((x, y), text(font: dfont, fill: tcol, weight: "bold", size: 8.5pt)[#body])
  }
  // 알파 (위)
  content((-4.8, 2.4), anchor: "west", text(font: dfont, fill: gold.darken(15%), weight: "black", size: 8.5pt)[알파])
  bx(-1.6, 1.8, 2.6, gold, dark, "믿음 · 선언")
  line((-0.3, 1.8), (1.6, 1.8), stroke: 1.6pt + gold.darken(10%), mark: (end: ">"))
  bx(3.0, 1.8, 2.2, dark, on-dark, "현실")
  content((0.6, 1.25), text(font: dfont, fill: muted, size: 6.5pt)[믿음이 현실을 만든다])
  // 베타 (아래)
  content((-4.8, 0.0), anchor: "west", text(font: dfont, fill: crimson, weight: "black", size: 8.5pt)[베타])
  bx(-1.6, -0.6, 2.2, crimson-soft, crimson, "현실")
  line((-0.5, -0.6), (1.4, -0.6), stroke: 1.2pt + crimson, mark: (end: ">"))
  bx(3.0, -0.6, 2.6, crimson-soft, crimson, "믿음 수정")
  content((0.7, -1.15), text(font: dfont, fill: muted, size: 6.5pt)[현실에 믿음을 끌려준다])
})

// ─────────────────────────────────────────────
// [should] 통제 가능/불가능 동심원 (스토아)
// ─────────────────────────────────────────────
#let dia-control-circle() = cetz.canvas(length: 1cm, {
  circle((0, 0), radius: 3.2, fill: crimson-soft, stroke: 1pt + crimson)
  circle((0, 0), radius: 1.5, fill: gold, stroke: none)
  content((0, 2.4), text(font: dfont, fill: crimson, weight: "bold", size: 8pt)[통제 불가능])
  content((0, 0.15), text(font: dfont, fill: dark, weight: "black", size: 9pt)[통제 가능])
  content((0, -0.45), text(font: dfont, fill: dark, size: 6.5pt)[나의 관점 하나])
  content((0, -2.25), text(font: dfont, fill: muted, size: 6pt)[그녀의 예의 · 사생활 · 가치관 · 10분 뒤 행동])
  content((4.0, 0), anchor: "west", text(font: dfont, fill: gold.darken(18%), size: 7.5pt, weight: "bold")[← 에너지를\ 안쪽에만\ 쏟아라])
})

// ─────────────────────────────────────────────
// [should] 정체성 게임 — 방사형 페르소나
// ─────────────────────────────────────────────
#let dia-identity-game() = cetz.canvas(length: 1cm, {
  // 좌: 뻔한 남자
  circle((-5.0, 0), radius: 0.9, fill: muted.lighten(20%), stroke: none)
  content((-5.0, 0), text(font: dfont, fill: white, size: 7pt)[상남자\ 하나뿐])
  content((-5.0, -1.4), text(font: dfont, fill: muted, size: 7pt)[뻔한 남자])
  // 우: 다채로운 유혹자
  let petals = ("섹시", "소년미", "야수", "철학자", "애교", "장난기")
  let cx = 1.5
  for (i, p) in petals.enumerate() {
    let ang = 90deg - i * 60deg
    let px = cx + 2.3 * calc.cos(ang)
    let py = 2.3 * calc.sin(ang)
    line((cx, 0), (px, py), stroke: 0.8pt + gold.transparentize(30%))
    circle((px, py), radius: 0.62, fill: gold.transparentize(55%), stroke: 0.8pt + gold.darken(10%))
    content((px, py), text(font: dfont, fill: ink, size: 7pt, weight: "bold")[#p])
  }
  circle((cx, 0), radius: 0.95, fill: dark, stroke: none)
  content((cx, 0), text(font: dfont, fill: gold, weight: "black", size: 9pt)[나])
  content((cx, -3.1), text(font: dfont, fill: gold.darken(15%), size: 7.5pt, weight: "bold")[다채로운 정체성])
})

// ─────────────────────────────────────────────
// [should] BURDEN OF PERFORMANCE — 출발선 대비
// ─────────────────────────────────────────────
#let dia-burden() = cetz.canvas(length: 1cm, {
  // 여자 게이지 (가득)
  rect((-3.5, 0), (-2.0, 4.0), fill: rgb("#E8E6EA"), stroke: none)
  rect((-3.5, 0), (-2.0, 3.7), fill: gold, stroke: none)
  content((-2.75, 4.4), text(font: dfont, fill: ink, weight: "bold", size: 8pt)[여자])
  content((-2.75, -0.5), text(font: dfont, fill: muted, size: 6.5pt)[출발선=가득\ (생명 창조)])
  // 남자 게이지 (0에서 시작, 상승)
  rect((2.0, 0), (3.5, 4.0), fill: rgb("#E8E6EA"), stroke: none)
  rect((2.0, 0), (3.5, 1.4), fill: dark, stroke: none)
  line((2.75, 1.5), (2.75, 3.7), stroke: 1.4pt + gold.darken(10%), mark: (end: ">"))
  content((2.75, 4.4), text(font: dfont, fill: ink, weight: "bold", size: 8pt)[남자])
  content((2.75, -0.5), text(font: dfont, fill: muted, size: 6.5pt)[출발선=0\ (증명으로 채운다)])
  content((0, 2.0), text(font: dfont, fill: crimson, weight: "bold", size: 8pt)[증명은\ 숙명이다])
})

// ─────────────────────────────────────────────
// [should] 모든 것은 기회다 — 같은 사건 두 갈래
// ─────────────────────────────────────────────
#let dia-opportunity() = cetz.canvas(length: 1cm, {
  rect((-1.8, 1.4), (1.8, 2.3), fill: dark, stroke: none, radius: 0.1)
  content((0, 1.85), text(font: dfont, fill: on-dark, weight: "bold", size: 8.5pt)[동일한 고통·사건])
  // 위 갈래: 저주
  line((1.8, 2.0), (3.6, 3.0), stroke: 1.2pt + muted, mark: (end: ">"))
  rect((3.6, 2.6), (7.2, 3.5), fill: paper-soft, stroke: none, radius: 0.1)
  content((5.4, 3.05), text(font: dfont, fill: muted, size: 8pt)[저주로 수용 → 붕괴])
  // 아래 갈래: 창조
  line((1.8, 1.7), (3.6, 0.7), stroke: 1.4pt + gold.darken(10%), mark: (end: ">"))
  rect((3.6, 0.2), (7.2, 1.1), fill: gold, stroke: none, radius: 0.1)
  content((5.4, 0.65), text(font: dfont, fill: dark, weight: "bold", size: 8pt)[창조로 수용 → 성장])
  content((2.7, 1.85), text(font: dfont, fill: crimson, size: 6.5pt, weight: "bold")[차이는\ 태도뿐])
})

// ─────────────────────────────────────────────
// [should] 어프로치-미드게임-엔드게임 타임라인
// ─────────────────────────────────────────────
#let dia-midgame() = cetz.canvas(length: 1cm, {
  let nodes = (
    ("어프로치", "떳떳이 다가갔나"),
    ("미드게임", "본질을 관찰·흐름 창조"),
    ("엔드게임", "진짜 나로 매력 폭발"),
  )
  for (i, n) in nodes.enumerate() {
    let x = i * 3.6
    circle((x, 1.0), radius: 0.45, fill: if i == 2 {gold} else {dark}, stroke: none)
    content((x, 1.0), text(font: dfont, fill: if i == 2 {dark} else {gold}, weight: "black", size: 10pt)[#str(i+1)])
    content((x, 0.1), text(font: dfont, fill: ink, weight: "bold", size: 8.5pt)[#n.at(0)])
    content((x, -0.45), text(font: dfont, fill: muted, size: 6.5pt)[#n.at(1)])
    if i < nodes.len() - 1 {
      line((x + 0.5, 1.0), (x + 3.1, 1.0), stroke: 1.2pt + gold.darken(5%), mark: (end: ">"))
    }
  }
})

// ─────────────────────────────────────────────
// [must] 매력 정규분포 — 상위 5%
// ─────────────────────────────────────────────
#let dia-normal() = cetz.canvas(length: 1cm, {
  let f(x) = 3.0 * calc.exp(-calc.pow(x - 4.5, 2) / 2.2)
  // 곡선 점
  let pts = ()
  for i in range(0, 91) { let x = i / 10; pts.push((x, f(x))) }
  // 상위 5% 음영 (우측 꼬리)
  let cut = 7.0
  let fillpts = ((cut, 0),)
  for i in range(70, 91) { let x = i / 10; fillpts.push((x, f(x))) }
  fillpts.push((9.0, 0))
  line(..fillpts, close: true, fill: gold.transparentize(25%), stroke: none)
  // 평균 구간 음영(연회색)
  let midpts = ((1.0, 0),)
  for i in range(10, 71) { let x = i / 10; midpts.push((x, f(x))) }
  midpts.push((cut, 0))
  line(..midpts, close: true, fill: rgb("#E3E1E5"), stroke: none)
  // 곡선
  line(..pts, stroke: 1.8pt + ink)
  // 축
  line((0, 0), (9.3, 0), stroke: 1pt + ink, mark: (end: ">"))
  content((9.3, -0.4), anchor: "east", text(font: dfont, fill: muted, size: 7.5pt)[매력 →])
  // 라벨
  content((4.5, 0.82), text(font: dfont, fill: muted, weight: "bold", size: 7pt)[평균 — 매력 파산자 다수])
  content((7.9, 1.3), text(font: dfont, fill: gold.darken(20%), weight: "black", size: 8pt)[상위 5%])
  content((7.9, 0.85), text(font: dfont, fill: gold.darken(20%), size: 7pt)[최상위 유혹자])
  line((7.9, 0.55), (7.7, 0.2), stroke: 0.8pt + gold.darken(20%), mark: (end: ">"))
  content((4.5, 3.5), text(font: dfont, fill: ink, size: 7.5pt, weight: "bold")[이 선을 가르는 건 돈·외모가 아니라 '정체성'이다])
})

// ─────────────────────────────────────────────
// [추가] 베스트셀링 남자 — 지갑 3요소
// ─────────────────────────────────────────────
#let dia-wallet() = cetz.canvas(length: 1cm, {
  let layer(y, fill, tcol, big, small) = {
    rect((-3.2, y), (3.2, y + 1.15), fill: fill, stroke: white + 1.5pt, radius: 0.1)
    content((-2.6, y + 0.57), anchor: "west", text(font: dfont, fill: tcol, weight: "bold", size: 9pt)[#big])
    content((3.0, y + 0.57), anchor: "east", text(font: dfont, fill: tcol.lighten(15%), size: 6.5pt)[#small])
  }
  // 지갑 = 3겹
  layer(0.0, dark, gold, "좋은 가죽", "내면·기반·재산·가치관")
  layer(1.25, dark2, on-dark, "좋은 디자인", "외모·피지컬·스타일·헤어")
  layer(2.5, gold, dark, "마케팅", "SNS·프로필·어프로치 양")
  content((0, 4.1), text(font: dfont, fill: ink, weight: "black", size: 10pt)[베스트 셀링 남자])
  line((0, 3.65), (0, 4.0), stroke: 1pt + muted)
  // 경고
  content((4.4, 2.0), anchor: "west", text(font: dfont, fill: crimson, size: 7.5pt, weight: "bold")[✕ 하나라도\ 빠지면\ 동대문 짝퉁])
  content((-4.4, 2.0), anchor: "east", text(font: dfont, fill: muted, size: 7.5pt)[세 겹이\ 다 있어야\ 세계로 나간다])
})

// ─────────────────────────────────────────────
// [should] 자존감 = 벽돌 건축물
// ─────────────────────────────────────────────
#let dia-selfesteem() = cetz.canvas(length: 1cm, {
  // 토대
  rect((-3.0, 0), (3.0, 0.8), fill: dark, stroke: none)
  content((0, 0.4), text(font: dfont, fill: gold, weight: "bold", size: 8pt)[믿음의 선택 — '나는 이미 그렇게 되었다'])
  // 벽돌 쌓기
  for i in range(0, 5) {
    let y = 0.9 + i * 0.62
    let off = if calc.rem(i, 2) == 0 { 0 } else { 0.4 }
    rect((-1.9 + off, y), (1.9 + off, y + 0.52), fill: gold.lighten(i * 4%), stroke: 0.6pt + white)
    content((off, y + 0.26), text(font: dfont, fill: dark, size: 6.5pt, weight: "bold")[오늘 지킨 약속])
  }
  content((0, 4.5), text(font: dfont, fill: gold.darken(15%), weight: "black", size: 8.5pt)[↑ 여자가 흉내 낼 수 없는 정신적 고지])
})

// ─────────────────────────────────────────────
// [should] 노력-보상 곡선 (고통의 문)
// ─────────────────────────────────────────────
#let dia-pain-curve() = cetz.canvas(length: 1cm, {
  // 축
  line((0, 1.4), (9.5, 1.4), stroke: 0.8pt + muted)  // 기준선(감정 0)
  line((0, -0.4), (0, 4.4), stroke: 1pt + ink, mark: (end: ">"))
  content((-0.3, 4.3), anchor: "east", text(font: dfont, fill: muted, size: 7pt)[감정])
  line((0, 1.4), (9.5, 1.4), stroke: 0.8pt + muted)
  content((9.5, 1.0), anchor: "east", text(font: dfont, fill: muted, size: 7pt)[시도 →])
  // 곡선: 골짜기 후 11번째 급상승
  let pts = ()
  for i in range(0, 41) {
    let x = i / 4.3
    let v = if x < 7.5 { 1.4 - 0.8 * calc.sin(x * 0.42) } else { 1.4 + (x - 7.5) * 1.6 }
    pts.push((x, v))
  }
  line(..pts, stroke: 1.8pt + crimson)
  content((3.5, 0.2), text(font: dfont, fill: crimson, size: 7pt)[거절·무시의 골짜기 ('열 번은 차인다')])
  content((8.7, 4.0), anchor: "east", text(font: dfont, fill: gold.darken(15%), weight: "bold", size: 7.5pt)[11번째\ 보상])
  content((5.0, -0.9), text(font: dfont, fill: muted, size: 7pt)[고통이라는 문을 지나야 쾌락이 온다])
})

// ─────────────────────────────────────────────
// [should] 초의미(Logos) 2기둥 신전
// ─────────────────────────────────────────────
#let dia-logos() = cetz.canvas(length: 1cm, {
  // 머릿돌
  rect((-4.0, 3.4), (4.0, 4.3), fill: dark, stroke: none)
  content((0, 3.85), text(font: dfont, fill: gold, weight: "black", size: 9.5pt)[초의미 (Logos) — 나만의 존재 이유])
  // 지붕(삼각)
  line((-4.4, 4.3), (4.4, 4.3), (0, 5.4), close: true, fill: gold, stroke: none)
  // 두 기둥
  rect((-3.2, 0.3), (-1.4, 3.35), fill: gold.transparentize(15%), stroke: none)
  content((-2.3, 1.825), text(font: dfont, fill: dark, weight: "black", size: 8.5pt)[창조])
  rect((1.4, 0.3), (3.2, 3.35), fill: gold.transparentize(15%), stroke: none)
  content((2.3, 1.825), text(font: dfont, fill: dark, weight: "black", size: 8.5pt)[체험])
  // 바닥
  rect((-3.6, 0), (3.6, 0.3), fill: dark2, stroke: none)
  // 기둥 부제 (바닥 아래)
  content((-2.3, -0.35), text(font: dfont, fill: muted, size: 6.5pt)[대체불가 서사])
  content((2.3, -0.35), text(font: dfont, fill: muted, size: 6.5pt)[음악·여행·성찰])
})

// ─────────────────────────────────────────────
// [should] 오만 vs 주는 자세 — 감정 흐름 회로
// ─────────────────────────────────────────────
#let dia-arrogance() = cetz.canvas(length: 1cm, {
  let person(x, y, lab) = {
    circle((x, y), radius: 0.55, fill: dark, stroke: none)
    content((x, y), text(font: dfont, fill: on-dark, size: 7pt)[#lab])
  }
  // o: 주는 자세 (흐름)
  content((-4.8, 2.4), anchor: "west", text(font: dfont, fill: gold.darken(15%), weight: "black", size: 8.5pt)[○ 주는 자세])
  person(-3.0, 1.5, "나")
  line((-2.4, 1.5), (1.0, 1.5), stroke: 1.6pt + gold.darken(10%), mark: (end: ">"))
  content((-0.7, 1.85), text(font: dfont, fill: gold.darken(15%), size: 7pt)[감정을 선물])
  person(1.6, 1.5, "여자")
  content((3.2, 1.5), anchor: "west", text(font: dfont, fill: muted, size: 6.5pt)[매력이 흐른다])
  // x: 오만(받는 자세, 차단)
  content((-4.8, -0.3), anchor: "west", text(font: dfont, fill: crimson, weight: "black", size: 8.5pt)[✕ 오만 (받는 자세)])
  person(-3.0, -1.2, "나")
  line((1.0, -1.2), (-2.4, -1.2), stroke: 1.2pt + crimson, mark: (end: ">"))
  content((-0.7, -0.85), text(font: dfont, fill: crimson, size: 7pt)[기대만 한다])
  person(1.6, -1.2, "여자")
  // 차단선
  line((-0.55, -1.8), (-0.05, -0.6), stroke: 2pt + crimson)
  line((-0.05, -1.8), (-0.55, -0.6), stroke: 2pt + crimson)
  content((3.2, -1.2), anchor: "west", text(font: dfont, fill: muted, size: 6.5pt)[감정 흐름 정지])
})

// ─────────────────────────────────────────────
// [원본 p31] 정체성 나무 — 뿌리=정체성 / 가지=기술 / 잎=멘트
// ─────────────────────────────────────────────
#let dia-tree() = cetz.canvas(length: 1cm, {
  content((0, 5.7), text(font: dfont, fill: ink, weight: "bold", size: 8.5pt)[뿌리가 깊어야 잎이 산다])
  // 수관(잎=멘트)
  circle((0, 4.0), radius: 1.5, fill: gold.transparentize(60%), stroke: none)
  for p in ((-0.8, 4.3), (0.7, 4.4), (0, 4.9), (-0.4, 3.6), (0.9, 3.8), (0.3, 4.1)) {
    circle(p, radius: 0.28, fill: gold.transparentize(15%), stroke: none)
  }
  content((2.3, 4.5), anchor: "west", text(font: dfont, fill: muted, size: 8pt)[잎 = 멘트])
  // 가지(기술)
  line((0, 2.6), (-1.3, 3.6), stroke: 1.6pt + dark2)
  line((0, 2.6), (1.2, 3.5), stroke: 1.6pt + dark2)
  line((0, 2.2), (0.9, 2.9), stroke: 1.4pt + dark2)
  content((2.3, 3.1), anchor: "west", text(font: dfont, fill: muted, size: 8pt)[가지 = 기술])
  // 줄기
  rect((-0.28, 0), (0.28, 2.7), fill: dark2, stroke: none)
  // 지면
  line((-3.4, 0), (3.4, 0), stroke: (paint: muted, thickness: 0.8pt, dash: "dashed"))
  // 뿌리(정체성)
  for e in ((-2.3, -1.6), (-1.1, -2.0), (0, -2.2), (1.1, -2.0), (2.3, -1.6)) {
    line((0, 0), e, stroke: 2pt + gold)
  }
  content((0, -2.6), text(font: dfont, fill: gold.darken(15%), weight: "black", size: 10pt)[뿌리 = 정체성])
})

// ─────────────────────────────────────────────
// [원본 p90] 기버(GIVER) 시소 — 주고받음의 균형
// ─────────────────────────────────────────────
#let dia-giver() = cetz.canvas(length: 1cm, {
  // 받침(삼각)
  line((-0.7, 0), (0.7, 0), (0, 1.0), close: true, fill: dark, stroke: none)
  // 널빤지(나 쪽이 살짝 무거움)
  line((-3.4, 1.45), (3.4, 0.6), stroke: 4pt + gold.darken(10%))
  // 나 / 여자
  circle((-3.0, 1.95), radius: 0.5, fill: dark, stroke: none)
  content((-3.0, 1.95), text(font: dfont, fill: on-dark, size: 7pt)[나])
  circle((3.0, 1.05), radius: 0.5, fill: dark, stroke: none)
  content((3.0, 1.05), text(font: dfont, fill: on-dark, size: 7pt)[여자])
  // 주는 화살표
  line((-2.3, 2.3), (2.3, 1.4), stroke: 1pt + gold.darken(10%), mark: (end: ">"))
  content((0, 2.4), text(font: dfont, fill: gold.darken(15%), size: 7.5pt, weight: "bold")[준다 — 열에 한둘만])
  content((0, -0.7), text(font: dfont, fill: muted, size: 7.5pt)[너무 많이 주면 기운다. 균형을 쥔 자가 힘을 가진다])
})

// ─────────────────────────────────────────────
// [원본 p119] 언행의 범위 — 알파(넓음) vs 베타(좁음)
// ─────────────────────────────────────────────
#let dia-speech-range() = cetz.canvas(length: 1cm, {
  line((-4.3, 0.4), (4.3, 0.4), stroke: 1pt + muted, mark: (start: ">", end: ">"))
  content((0, -0.1), text(font: dfont, fill: muted, size: 7pt)[← 언행의 자유도(범위) →])
  // 알파 (넓음)
  rect((-3.8, 1.1), (3.8, 1.85), fill: gold, stroke: none, radius: 0.08)
  content((0, 1.475), text(font: dfont, fill: dark, weight: "bold", size: 8.5pt)[알파 — 거리낌 없이 넓다])
  // 베타 (좁음)
  rect((-0.7, 2.25), (0.7, 3.0), fill: muted.lighten(15%), stroke: none, radius: 0.08)
  content((0, 2.625), text(font: dfont, fill: white, weight: "bold", size: 7.5pt)[베타])
  content((1.0, 2.625), anchor: "west", text(font: dfont, fill: muted, size: 7.5pt)[— 눈치 보는 좁은 박스])
  content((0, 3.6), text(font: dfont, fill: ink, size: 7.5pt, weight: "bold")[말과 행동의 폭이 넓을수록 매력은 커진다])
})
