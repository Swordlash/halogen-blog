const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  entry: ['./example2-workaround/assets/index.js', './example2-workaround/assets/style.scss', './example2-workaround/src/Button.js'],
  output: {
    filename: 'main.js',
    path: path.resolve(__dirname, '../../dist'),
  },
  resolve: {
    fallback: {
      os: false,
      fs: false,
      child_process: false,
      path: false,
    }
  },
  module: {
    rules: [
      {
        test: /\.s[ac]ss$/i,
        use: [ "style-loader", "css-loader", "sass-loader"],
      }
    ],
  },
  plugins: 
    [ new HtmlWebpackPlugin({
        title: 'Blog'
    })]
};