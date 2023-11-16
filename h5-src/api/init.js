import axios from 'axios'

// 配置环境变量
let apiUrl = ''
if (process.env.NODE_ENV === 'production') {
  apiUrl = 'http://116.62.213.90'
}

axios.defaults.baseURL = apiUrl + '/api'
axios.defaults.withCredentials = true
axios.defaults.timeout = 10000
axios.interceptors.request.use(
  config => {
    return config
  },
  err => {
    return Promise.reject(err)
  }
)

axios.interceptors.response.use(
  response => {
    return response
  },
  error => {
    return Promise.reject(error.response) // 返回接口返回的错误信息
  }
)

export {
  axios
}
