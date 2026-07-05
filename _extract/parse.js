const fs = require('fs');
const xml = fs.readFileSync(process.argv[2], 'utf8');

// Split into paragraphs
const paras = xml.split(/<w:p[ >]/).slice(1);
const out = [];
for (const p of paras) {
  // style
  const styleM = p.match(/<w:pStyle w:val="([^"]+)"/);
  const style = styleM ? styleM[1] : '';
  // collect text runs
  const texts = [...p.matchAll(/<w:t[^>]*>([\s\S]*?)<\/w:t>/g)].map(m => m[1]);
  let text = texts.join('')
    .replace(/&amp;/g, '&').replace(/&lt;/g, '<').replace(/&gt;/g, '>')
    .replace(/&quot;/g, '"').replace(/&apos;/g, "'");
  // detect image
  const hasImg = /<w:drawing>|<pic:pic|<w:pict/.test(p);
  const imgEmbed = [...p.matchAll(/r:embed="([^"]+)"/g)].map(m => m[1]);
  if (hasImg) out.push(`[IMG${imgEmbed.length?':'+imgEmbed.join(','):''}]`);
  if (text.trim() || style) {
    const tag = style ? `{${style}} ` : '';
    out.push(tag + text);
  }
}
fs.writeFileSync(process.argv[3], out.join('\n'), 'utf8');
console.log('paras:', paras.length, 'lines:', out.length);
console.log('chars:', out.join('\n').length);
