const CleanWebpackPlugin = require("clean-webpack-plugin");
const path = require("path");

module.exports = {
  entry: {
    "frontend/app": "./src/javascripts/index.tsx"
  },

  output: {
    path: path.resolve(__dirname, "../public/assets"),
    filename: "[name].js",
    publicPath: "/assets"
  },

  devtool: "inline-source-map",

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
  },

  plugins: [
    new CleanWebpackPlugin(["frontend"], {
      root: path.resolve(__dirname, `../public/assets`),
      verbose: true
    })
  ]
};
