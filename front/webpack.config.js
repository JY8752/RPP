/* eslint-disable no-undef */
const path = require('path')
const Dotenv = require('dotenv-webpack')
const enviroment = process.env.NODE_ENV || 'develop'

module.exports = {
  plugins: [
    new Dotenv({ 
      systemvars: true,
      path: path.resolve(__dirname, `.env.${enviroment}`)
    })
  ],
  entry: './src/main.js',
  output: {
    path: path.resolve(__dirname, 'public'),
    publicPath: '/public/',
    filename: 'bundle.js'
  },
  devtool: 'inline',
  module: {
    rules: [
      {
        test: /\.riot$/,
        exclude: /node_modules/,
        use: [{
          loader: '@riotjs/webpack-loader',
          options: {
            hot: true
          }
        }]
      }
    ]
  },
  //webpack-dev-server用設定
  devServer: {
    host: '0.0.0.0',
    open: true,//ブラウザを自動で開く
    openPage: 'index.html',//自動で指定したページを開く
    //contentBase: path.join(__dirname, 'public'),// HTML等コンテンツのルートディレクトリ
    watchContentBase: true,//コンテンツの変更監視をする
    port: 8080 // ポート番号
  }
}