// Installs BGS into webR from the live repository, as a quarto-live page
// would, and looks up one point.
//   node tools/smoke-webr.mjs https://geol-skills.github.io/packages
import { WebR } from "webr";

const repo = process.argv[2];
const webR = new WebR();
await webR.init();
await webR.evalRVoid(`webr::install("BGS", repos = "${repo}")`);
const lex = await webR.evalRString(
  "BGS::Bedrock(54.7733, -1.5762)$lex"
);
console.log(`Durham Cathedral bedrock: ${lex}`);
webR.close();
if (lex !== "PSMCM") {
  process.exit(1);
}
