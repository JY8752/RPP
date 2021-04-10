import instance from './index.js'

export default {
  getUserList() {
    return instance.get('/users')
  },
  createUser(params) {
    return instance.post('/users', params)
  },
  getUser(id) {
    return instance.get(`/users/${id}`)
  }
}
