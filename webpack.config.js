/* eslint-disable no-undef */
const path = require('path')
//const webpack = require('webpack')

module.exports = {
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
    }
}