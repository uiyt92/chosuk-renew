// ============================================================
// theme.typ — 초석(礎石) 디자인 토큰
// 팔레트 · 폰트 · 치수. 모든 컴포넌트가 이 토큰을 참조한다.
// ============================================================

// ---- 팔레트 (THE LEGACY 럭셔리 절충) ----
#let ink     = rgb("#16161A")   // 본문 잉크
#let paper   = rgb("#FFFFFF")   // 본문 배경
#let dark    = rgb("#0E0E12")   // 다크 페이지(표지·막 디바이더)
#let dark2   = rgb("#1A1A22")   // 다크 보조
#let gold    = rgb("#B68A3E")   // 골드 액센트
#let gold-lt = rgb("#D8B978")   // 밝은 골드
#let crimson = rgb("#9E1B1B")   // 크림슨 강조/경고
#let muted   = rgb("#6B6B73")   // 캡션·보조 텍스트
#let faint   = rgb("#9A9AA2")   // 더 옅은 보조
#let rule    = rgb("#E2E2E6")   // 옅은 구분선
#let paper-soft = rgb("#F7F6F3") // 박스 배경(아주 옅은 웜그레이)
#let gold-soft  = rgb("#F6EFDF") // 골드 박스 배경
#let crimson-soft = rgb("#F7E9E7") // 크림슨 박스 배경

// 다크 위에서 쓰는 톤
#let on-dark      = rgb("#F2F0EA")
#let on-dark-mute = rgb("#9C968A")

// ---- 폰트 ----
// Pretendard(한글/영문, 굵기 완전 제어) + Noto Sans KR(한자 폴백)
#let font-body = ("Pretendard", "Noto Sans KR")

// 굵기 토큰
#let w-thin   = 200
#let w-light  = 300
#let w-reg    = 400
#let w-med    = 500
#let w-semi   = 600
#let w-bold   = 700
#let w-xbold  = 800
#let w-black  = 900

// ---- 치수 ----
#let page-margin = (top: 2.7cm, bottom: 2.7cm, x: 2.7cm)
#let body-size = 11.5pt
#let body-leading = 1.3em      // par leading (넓은 행간)
#let body-spacing = 2.0em      // 문단 간격 (여유로운 단락)
