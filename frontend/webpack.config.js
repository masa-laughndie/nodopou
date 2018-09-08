const CleanWebpackPlugin = require("clean-webpack-plugin");
const WebpackSprocketsRailsManifestPlugin = require("webpack-sprockets-rails-manifest-plugin");
const ExtractTextPlugin = require("extract-text-webpack-plugin");
// const webpack = require("webpack");

const path = require("path");

const FILENAME = "[name]-[chunkhash]";

const extractCSS = new ExtractTextPlugin(`${FILENAME}.css`);

module.exports = {
  entry: {
    "frontend/vendor": ["jquery"],
    "frontend/app": "./src/javascripts/index.tsx"
  },

  output: {
    path: path.resolve(__dirname, "../public/assets"),
    filename: `${FILENAME}.js`,
    chunkFilename: `${FILENAME}.js`
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
      },
      {
        test: /\.css$/,
        use: extractCSS.extract(["css-loader"])
      },
      {
        test: /\.(jpeg|jpg|gif|png|svg|eot|woff|woff2|ttf|wav|mp3)$/,
        use: {
          loader: "file-loader",
          options: {
            name: "[path][name].[hash].[ext]",
            outputPath: "frontend/images/",
            publicPath: "/assets/frontend/images/"
          }
        }
      }
    ]
  },

  plugins: [
    new CleanWebpackPlugin(["frontend"], {
      root: path.resolve(__dirname, `../public/assets`),
      verbose: true
    }),
    extractCSS,
    new WebpackSprocketsRailsManifestPlugin({
      manifestFile: "../../config/sprockets-manifest.json"
    })
  ],

  optimization: {
    splitChunks: {
      name: true,
      minChunks: Infinity
    },
    runtimeChunk: {
      name: "frontend/manifest"
    }
  }
};
