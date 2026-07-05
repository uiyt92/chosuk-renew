export const meta = {
  name: 'choseok-visual-qa',
  description: '초석 90p PDF 전 페이지 비주얼 QA — 배치/레이아웃/텍스트 가독성 점검(비전).',
  phases: [{ title: 'QA', detail: '페이지 배치별 비전 점검' }],
}

const ISSUE_SCHEMA = {
  type: 'object',
  additionalProperties: false,
  required: ['issues'],
  properties: {
    issues: {
      type: 'array',
      items: {
        type: 'object',
        additionalProperties: false,
        required: ['page', 'severity', 'category', 'desc'],
        properties: {
          page: { type: 'integer', description: '문제가 있는 페이지 번호(파일명 p-NN의 NN)' },
          severity: { type: 'string', enum: ['blocker', 'major', 'minor'] },
          category: {
            type: 'string',
            enum: ['clipping', 'overflow', 'orphan-header', 'blank-page', 'diagram-broken',
                   'image-quality', 'text-readability', 'font-glitch', 'placement', 'spacing', 'other'],
          },
          desc: { type: 'string', description: '구체적으로 무엇이 어떻게 잘못됐는지(한국어, 한 줄)' },
          fix_hint: { type: 'string', description: '권장 수정 방향(선택)' },
        },
      },
    },
  },
}

const DIR = 'C:/Users/youngdo1/초석 업그레이드/_qa'
const TOTAL = 90
const BATCH = 12

// build page batches
const batches = []
for (let s = 1; s <= TOTAL; s += BATCH) {
  const pages = []
  for (let p = s; p < s + BATCH && p <= TOTAL; p++) pages.push(p)
  batches.push(pages)
}

const RUBRIC = String.raw`
당신은 프리미엄 PDF(한국어, A4)의 비주얼 QA 검수자다. 제공된 페이지 PNG들을 한 장씩 눈으로 본 뒤, 결함만 issues 배열로 보고한다(문제 없으면 빈 배열).

[점검 항목]
1) 배치(placement/overflow/clipping): 도식·콜아웃 박스·미션 박스·before-after·카톡 갤러리가 페이지 밖으로 잘리거나(clipping), 박스/이미지가 페이지 경계를 넘거나(overflow), 본문과 동떨어진 엉뚱한 위치에 있지 않은가.
2) 고아/빈 페이지(orphan-header/blank-page): 섹션 제목만 페이지 맨 아래에 홀로 남고 본문은 다음 장으로 넘어갔는가(orphan). 의미 없이 거의 빈 페이지가 있는가.
3) 도식(diagram-broken): cetz 도식의 선/도형/라벨이 겹치거나, 텍스트가 도형 밖으로 삐져나오거나, 잘려 보이는가.
4) 이미지 품질(image-quality): 카톡 캡처가 과도하게 흐리거나 깨지거나, 비율이 찌그러졌는가.
5) 텍스트 가독성(text-readability/spacing): 양쪽정렬로 인한 과도한 단어 간격(강줄), 한 줄짜리 외톨이 줄(widow/orphan line), 행간 과밀/과소.
6) 폰트(font-glitch): 한자(礎石 등)나 특수문자가 □(두부)·물음표로 깨졌는가. 굵기가 의도와 다르게 보이는가.

[심각도] blocker=배포 불가(잘림·깨짐·내용 손실) / major=눈에 띄게 어색(고아헤더·강줄 심함·도식 겹침) / minor=사소(약간의 여백 불균형).
[주의] 표지·막 디바이더(다크 풀페이지)·갤러리 페이지는 의도된 디자인이다. 단순히 "여백이 많다/이미지가 많다"는 결함이 아니다. 실제 가독성·완성도를 해치는 것만 보고하라.
page 번호는 반드시 파일명 p-NN 의 정수 NN으로 적는다.
`

phase('QA')
const results = await parallel(batches.map((pages) => () => {
  const paths = pages.map(p => `${DIR}/p-${String(p).padStart(2, '0')}.png`)
  const list = paths.map(x => `- ${x}`).join('\n')
  return agent(
    `${RUBRIC}\n\n[검수 대상 — 이 PNG들을 모두 Read로 열어 한 장씩 보라]\n${list}\n\n각 페이지를 실제로 Read한 뒤 결함만 issues로 반환.`,
    { label: `qa:p${pages[0]}-${pages[pages.length-1]}`, phase: 'QA', schema: ISSUE_SCHEMA }
  )
}))

const all = []
for (const r of results) if (r && r.issues) all.push(...r.issues)
all.sort((a, b) => a.page - b.page)
const sev = { blocker: 0, major: 0, minor: 0 }
for (const i of all) sev[i.severity] = (sev[i.severity] || 0) + 1
return { total_issues: all.length, by_severity: sev, issues: all }
