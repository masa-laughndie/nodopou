import { configure } from "@storybook/react";

// automatically import all files ending in *.stories.js
// const req = require.context('../stories', true, /.stories.js$/);
// function loadStories() {
//   req.keys().forEach(filename => req(filename));
// }

function importAll(r) {
  r.keys().forEach(r);
}

function loadStories() {
  importAll(require.context("../src", true, /\.story\.(js|tsx?)$/));
  importAll(require.context("../stories", true, /\.story\.(js|tsx?)$/));
}

configure(loadStories, module);
