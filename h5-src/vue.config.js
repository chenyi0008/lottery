const { defineConfig } = require('@vue/cli-service')

const px2rem = require('postcss-pxtorem')
const postcss = px2rem({ rootValue: 75, propList: ['*'], })

module.exports = defineConfig({
  transpileDependencies: true,
  publicPath: process.env.NODE_ENV === 'development' ? '/' : './',
  devServer:{
    hot: true,
    proxy:{
      '/api': {
        target: 'http://116.62.213.90', // 接口代理地址 本地调试时需更换至接口对应地址
        changeOrigin: true,
        pathRewrite: {
          '/^api': 'api/'
        }
      }
    }
  },
  
  css: {
    loaderOptions: {
      postcss: {
        postcssOptions:{
          plugins: [postcss]
        }
      }
    }
  }
  
})
