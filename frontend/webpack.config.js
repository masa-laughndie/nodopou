const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const CleanWebpackPlugin = require('clean-webpack-plugin');
const WebpackSprocketsRailsManifestPlugin = require('webpack-sprockets-rails-manifest-plugin');
const webpack = require('webpack');
const path = require('path');

const isProduction = process.env.NODE_ENV === 'production';

const FILENAME = isProduction ? '[name]-[chunkhash]' : '[name]';

function getLoaders({ modules }) {
  return [
    MiniCssExtractPlugin.loader,
    {
      loader: require.resolve('css-loader'),
      options: {
        localIdentName: isProduction ? '[hash:base64:5]' : '[local]',
        modules: modules ? true : undefined,
        minimize: isProduction,
        importLoaders: 2,
      },
    },
    {
      loader: require.resolve('postcss-loader'),
      options: {
        config: {
          path: require.resolve('./postcss.config.js'),
        },
      },
    },
    {
      loader: require.resolve('sass-loader'),
    },
  ];
}

module.exports = {
  entry: {
    'frontend/global': './src/javascripts/global.ts',
    'frontend/app': './src/javascripts/index.tsx',
  },

  output: {
    path: path.resolve(__dirname, '../public/assets'),
    filename: `${FILENAME}.js`,
    chunkFilename: `${FILENAME}.js`,
  },

  devtool: isProduction ? undefined : 'inline-source-map',

  resolve: {
    extensions: ['.ts', '.tsx', '.js', 'json', '.css', '.scss'],
  },

  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: { loader: require.resolve('babel-loader') },
      },
      {
        test: /\.(ts|tsx)$/,
        exclude: /node_modules/,
        use: { loader: require.resolve('ts-loader') },
      },
      {
        test: /\.css$/,
        exclude: /\.module\.s?css$/,
        use: getLoaders({ modules: false }),
      },
      {
        test: /\.module\.scss$/,
        use: getLoaders({ modules: true }),
      },
      {
        test: /\.(jpeg|jpg|gif|png|svg|eot|woff|woff2|ttf|wav|mp3)$/,
        use: {
          loader: require.resolve('file-loader'),
          options: {
            name: '[path][name]-[hash].[ext]',
            outputPath: 'frontend/images/',
            publicPath: '/assets/frontend/images/',
          },
        },
      },
    ],
  },

  plugins: [
    new CleanWebpackPlugin(['frontend'], {
      root: path.resolve(__dirname, `../public/assets`),
      verbose: true,
    }),
    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery',
    }),
    new webpack.EnvironmentPlugin({
      NODE_ENV: isProduction ? 'production' : 'development',
    }),
    new WebpackSprocketsRailsManifestPlugin({
      manifestFile: '../../config/sprockets-manifest.json',
    }),
    new MiniCssExtractPlugin({
      filename: isProduction ? '[name]-[contenthash].css' : '[name].css',
      chunkFilename: isProduction ? '[name]-[contenthash].css' : '[name].css',
    }),
  ],

  optimization: {
    splitChunks: {
      name: true,
      minChunks: Infinity,
    },
    runtimeChunk: {
      name: 'frontend/manifest',
    },
  },
};
