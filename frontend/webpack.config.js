const path = require("path");

module.exports = {
  entry: "./src/javascripts/index.tsx",

  output: {
    path: path.resolve(__dirname, "./dist"),
    filename: "bundle.js"
  },

  // devtool: "source-map",

  resolve: {
    extensions: [".ts", ".tsx", ".js"]
  },

  module: {
    rules: [
      {
        test: /\.(ts|tsx)$/,
        use: [{ loader: "ts-loader" }]
      }
    ]
  }
};
