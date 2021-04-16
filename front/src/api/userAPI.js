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
  },
  updateUser(id, params) {
    return instance.put(`/users/${id}`, params)
  },
  deleteUser(id) {
    return instance.delete(`/users/${id}`)
  }
}
