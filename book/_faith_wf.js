export const meta = {
  name: 'choseok-faithfulness-audit',
  description: 'v2 재구성 콘텐츠가 원고(manuscript.txt)를 충실히 담았는지 — 누락된 핵심 내용 색출(막 단위 대조).',
  phases: [{ title: 'Audit', detail: '막별 원고 대조 누락 색출' }],
}

const DROP_SCHEMA = {
  type: 'object', additionalProperties: false, required: ['coverage_pct', 'drops'],
  properties: {
    coverage_pct: { type: 'integer', description: '원고 핵심 내용 중 산출물에 반영된 비율 추정(0-100)' },
    drops: {
      type: 'array',
      items: {
        type: 'object', additionalProperties: false, required: ['what', 'severity'],
        properties: {
          what: { type: 'string', description: '원고에는 있으나 산출물에서 빠진 구체적 내용(문장/사례/논거/비유/인용), 한국어' },
          manuscript_hint: { type: 'string', description: '원고에서의 대략 위치(첫 어절/줄 근처)' },
          severity: { type: 'string', enum: ['major', 'minor'] },
        },
      },
    },
  },
}

const MS = 'C:/Users/youngdo1/초석 업그레이드/_extract/manuscript.txt'
const CDIR = 'C:/Users/youngdo1/초석 업그레이드/book/content'

const ACTS = [
  { file: '01-prologue.typ', ranges: '101-170 (프롤로그 미친놈 101-136, 여성에게 대접 137-154, 3부작 155-170). 주의: 「한조의 정직 선언」과 「세 부류의 남자」는 원고에 없는 신설 섹션이므로 누락 대상이 아니다.' },
  { file: '02-act1.typ', ranges: '171-386, 465-512 (1.최상위유혹자란 171-216, 2.추구하는마음 217-249, 3.인정받기 250-285, 4.업쌓기 286-332, 5.정체성게임 333-386, 8.결과독립 465-512→3에 병합).' },
  { file: '03-act2.typ', ranges: '387-464, 513-575, 991-1028 (6.본심 387-445, 7.성적자유 446-464, 9.결핍 513-575, 19.ONEITIS 991-1028→9에 병합).' },
  { file: '04-act3.typ', ranges: '576-812, 813-866, 867-913 (10.챔피언십 576-626, 15.고통 813-866→10병합, 11.자존감 627-676, 12.스테이트 677-727, 16.엔트로피 867-913→12병합, 13.확신언어 728-774, 14.기버 775-812).' },
  { file: '05-act4.typ', ranges: '914-990, 1029-1149 (17.외모돈 914-955, 18.MPO 956-990→17병합, 20.남성성 1029-1055, 22.어둠삼원 1091-1149→20병합, 21.기대좌절 1056-1090).' },
  { file: '06-act5.typ', ranges: '1150-1401 (23.근원 1150-1193, 24.기회 1194-1249, 25.오만 1250-1300, 26.영웅서사 1301-1362, 에필로그 1363-1377, 다음단계 1378-1401). 주의: #offer 박스·연락처·면책은 신설이므로 대상 아님.' },
]

const RUBRIC = String.raw`
당신은 원고 충실성 감사관이다. 원본 원고(manuscript.txt)의 지정 구간과, 그 구간을 재구성한 Typst 산출물을 비교해, 원고에는 있으나 산출물에서 *빠진 핵심 내용*만 찾아낸다.

[판단 기준]
- 누락(drop)으로 볼 것: 원고의 구체적 사례·일화·비유·인용·논거·핵심 주장·리스트 항목이 산출물에 전혀 반영되지 않은 경우.
- 누락이 아닌 것: 표현을 다듬은 것(윤문), 문장 순서 조정, 중복 문장 1회로 통합, 군더더기 접속사 제거, 신설 섹션/컴포넌트(도식·미션·콜아웃·오퍼·면책) 추가. 이런 '편집'은 정상이며 누락이 아니다.
- 물결표(~)·표기 교정·'1000→1300' 같은 의도된 수치 통일은 누락이 아니다.
[심각도] major=문단급 내용/사례/논거 통째 누락. minor=한두 문장·디테일 누락.
[출력] coverage_pct(원고 핵심 대비 반영 비율 추정)와 drops 배열. 누락이 없으면 drops는 빈 배열.
원고는 Read로 해당 줄 구간(offset/limit)을 읽고, 산출물 파일도 Read로 전부 읽어 대조하라.
`

phase('Audit')
const results = await parallel(ACTS.map(a => () => agent(
  `${RUBRIC}\n\n[원고 파일] ${MS}\n[감사 대상 구간(원고 줄번호)] ${a.ranges}\n[산출물 파일] ${CDIR}/${a.file}\n\n원고 지정 구간과 산출물을 정독해 대조하고, 빠진 핵심 내용만 drops로 반환.`,
  { label: 'faith:' + a.file, phase: 'Audit', schema: DROP_SCHEMA }
)))

const out = {}
let majors = 0, minors = 0
for (let i = 0; i < ACTS.length; i++) {
  const r = results[i] || { coverage_pct: null, drops: [] }
  out[ACTS[i].file] = r
  for (const d of (r.drops || [])) { if (d.severity === 'major') majors++; else minors++; }
}
return { summary: { majors, minors }, by_file: out }
