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

const webpack = require('webpack');
const ExtractTextPlugin = require('extract-text-webpack-plugin');

// const isProduction = process.env.NODE_ENV === 'production';

// const FILENAME = isProduction ? "[name]-[chunkhash]" : "[name]";

module.exports = {
  resolve: {
    extensions: ['.ts', '.tsx', '.js', 'json', '.css', '.scss']
  },

  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: { loader: require.resolve('babel-loader') }
      },
      {
        test: /\.(ts|tsx)$/,
        exclude: /node_modules/,
        use: { loader: 'ts-loader' }
      },
      {
        test: /\.css$/,
        use: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          use: [
            {
              loader: require.resolve('css-loader'),
              options: {
                localIdentName: '[local]',
                modules: true
              }
            },
            'sass-loader'
          ]
        })
      },
      {
        test: /\.module\.scss$/,
        use: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          use: [
            {
              loader: require.resolve('css-loader'),
              options: {
                localIdentName: '[local]',
                modules: true,
                importLoaders: 2
              }
            },
            'sass-loader'
          ]
        })
      },
      {
        test: /\.(jpeg|jpg|gif|png|svg|eot|woff|woff2|ttf|wav|mp3)$/,
        use: {
          loader: 'file-loader',
          options: {
            name: '[name]-[hash].[ext]'
          }
        }
      }
    ]
  },

  plugins: [
    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery'
    }),
    new ExtractTextPlugin({ filename: 'styles.css', allChunks: true })
  ],

  stats: {
    // Suppress useless output
    children: false
  }
};
