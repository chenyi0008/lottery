# 红包雨项目

# vue-cli版本
v5

# node.js版本
v14+

## 安装项目依赖
```
npm install
```

### 开发的编译和热加载
```
npm run serve
```

### 生产的编译和压缩
```
npm run build
```

### 整理和修复文件
```
npm run lint
```

### 自定义配置
See [Configuration Reference](https://cli.vuejs.org/config/).


### 本地调试时注意
vue.config.js 文件中 接口代理地址需要更换为自己服务器的地址

``` js

proxy:{
  '/api': {
    target: '自己服务器地址', // 接口代理地址 本地调试时需更换至接口对应地址
    changeOrigin: true,
    pathRewrite: {
      '/^api': 'api/'
    }
  }
}

```

.env.development 中的环境变量需要修改为自己服务器的地址