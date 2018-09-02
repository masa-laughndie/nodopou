const path = require("path");

module.exports = {
<<<<<<< HEAD
  entry: {
    "frontend/app": "./src/javascripts/index.tsx"
  },

  output: {
    path: path.resolve(__dirname, "./dist"),
    filename: "[name].js"
=======
  entry: "./src/javascripts/index.tsx",

  output: {
    path: path.resolve(__dirname, "../app/assets/javascripts"),
    filename: "bundle.js"
  },

  // devtool: "source-map",

  resolve: {
    extensions: [".ts", ".tsx", ".js"]
>>>>>>> 0920fad... Setting webpack and tsconfig
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
