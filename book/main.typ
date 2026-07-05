#import "lib.typ": *
#import "diagrams.typ" as d

#show: template

// ───────────── 표지 ─────────────
#cover(
  title: "초석", hanja: "礎石",
  series: "한조 비기 · THE LEGACY",
  subtitle: "최상위 유혹자의 기본 마인드셋",
  tagline: "여자가 돈을 내고 만나는 남자의 비밀 — 기술이 아니라 정체성이다.",
  badges: (("15년", "현장의 정수"), ("1300명", "교제 경험"), ("상위 1%", "비밀 전수"), ("3부작", "THE LEGACY")),
)

#counter(page).update(1)

// ───────────── 저작권 고지 ─────────────
#v(1fr)
#callout(title: "저작권 및 추적 고지", kind: "crimson")[
  본 문서는 대한민국 저작권법의 보호를 받으며, 모든 권리는 *한조컴퍼니*에 있다. 본 자료에는 사내 개발자가 삽입한 *암호화된 개별식별코드*가 심겨 있어, 무단 복제·배포 시 배포자를 추적한다. 저작권 위반 시 5년 이하의 징역 또는 5천만 원 이하의 벌금과 민사상 손해배상이 청구될 수 있으며, 협약된 법무팀이 *무관용 원칙*으로 대응한다.

  #text(size: 9pt, fill: muted)[비즈니스 제안 · supernatural2354\@gmail.com]
]
#v(1fr)
#pagebreak()

// ───────────── 프롤로그 · 정직선언 · 세 부류 · 3부작 (카톡 후기 갤러리 포함) ─────────────
#include "content/01-prologue.typ"

#pagebreak()

// ───────────── 비주얼 목차 (원본 목차 챕터 반영) ─────────────
#toc-visual((
  ("1", "정체성 — 매력의 뿌리", "최상위 유혹자란 · 추구하는 마음 · 나에게 인정받기 · 업을 쌓기 · 정체성 게임"),
  ("2", "비움과 자유", "본심(OVERSOUL) · 성적 자유의 진짜 의미 · 결핍과 ONEITIS"),
  ("3", "단련과 마음의 힘", "챔피언십 · 자존감 · 스테이트 · 확신의 언어 · 기버(GIVER)"),
  ("4", "무장", "외모·돈과 MPO · 올바른 남성성과 어둠의 삼원 · 기대와 좌절"),
  ("5", "출정", "근원 · 모든 것은 기회다 · 오만 · 영웅적 서사 · 다음 단계"),
))

// ───────────── 1막 · 정체성 ─────────────
#act-divider(num: "1", roman: "Act I — Identity", title: "정체성",
  desc: "매력은 기술이 아니라 정체성이다. 무엇을 세울지 정하기 전에, 당신이 누구인지부터 정한다.")
#include "content/02-act1.typ"

// ───────────── 2막 · 비움과 자유 ─────────────
#act-divider(num: "2", roman: "Act II — Emptiness & Freedom", title: "비움과 자유",
  desc: "가면과 결핍을 비운다. 한 명에게 다 걸던 마음을 내려놓을 때, 비로소 선택할 자유가 생긴다.")
#include "content/03-act2.typ"

// ───────────── 3막 · 단련과 마음의 힘 ─────────────
#act-divider(num: "3", roman: "Act III — Forging the Inner Power", title: "단련과 마음의 힘",
  desc: "고통을 연료로 거듭난다. 자존감·스테이트·확신·풍요 — 보이지 않는 힘을 골조 단위로 단련한다.")
#include "content/04-act3.typ"

// ───────────── 4막 · 무장 ─────────────
#act-divider(num: "4", roman: "Act IV — Armament", title: "무장",
  desc: "단련된 정체성 위에 무기를 장착한다. 외모·돈의 근원, 올바른 남성성, 그리고 다루는 법.")
#include "content/05-act4.typ"

// ───────────── 5막 · 출정 ─────────────
#act-divider(num: "5", roman: "Act V — Sortie", title: "출정",
  desc: "근원을 향해 전장으로 나아간다. 모든 사건을 기회로 쓰는 자가, 자기만의 영웅 서사를 건다.")
#include "content/06-act5.typ"
