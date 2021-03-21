import instance from './index.js'

export default {
  getUserList() {
    return instance.get('/users')
  }
}
