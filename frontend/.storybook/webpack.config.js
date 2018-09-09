// you can use this file to add your custom webpack plugins, loaders and anything you like.
// This is just the basic way to add additional webpack configurations.
// For more information refer the docs: https://storybook.js.org/configurations/custom-webpack-config

// IMPORTANT
// When you add this file, we won't add the default configurations which is similar
// to "React Create App". This only has babel loader to load JavaScript.

// module.exports = {
//   plugins: [
//     // your custom plugins
//   ],
//   module: {
//     rules: [
//       // add your custom rules.
//     ],
//   },
// };

const isProduction = process.env.NODE_ENV === "production";

// const FILENAME = isProduction ? "[name]-[chunkhash]" : "[name]";

module.exports = {
  resolve: {
    extensions: [".ts", ".tsx", ".js", "json"]
  },

  module: {
    rules: [
      {
        test: /\.(ts|tsx)$/,
        exclude: /node_modules/,
        use: { loader: "ts-loader" }
      },
      {
        test: /\.css$/,
        use: { loader: "css-loader" }
      },

      {
        test: /\.(jpeg|jpg|gif|png|svg|eot|woff|woff2|ttf|wav|mp3)$/,
        use: {
          loader: "file-loader",
          options: {
            name: "[name]-[hash].[ext]"
          }
        }
      }
    ]
  },

  stats: {
    // Suppress useless output
    children: false
  }
};
