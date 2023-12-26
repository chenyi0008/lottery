import axios from 'axios'

axios.defaults.baseURL = '/api'
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
