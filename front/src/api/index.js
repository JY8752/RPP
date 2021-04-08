import axios from 'axios'
import * as AxiosLogger from 'axios-logger'

AxiosLogger.setGlobalConfig({
  method: true,
  url: true,
  data: true,
  status: true,
  headers: false,
  dateFormat: '[yyyy/mm/dd HH:MM:ss]'
})

const instance = axios.create()
instance.defaults.withCredentials = true
instance.defaults.baseURL = `${process.env.BASE_URL}/api/v1`
instance.interceptors.request.use(AxiosLogger.requestLogger)
instance.interceptors.response.use(AxiosLogger.responseLogger, (err) => {
  return AxiosLogger.errorLogger(err)
})

export default instance