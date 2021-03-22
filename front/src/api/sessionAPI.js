import instance from './index.js'

export default {
  signin(id, password) {
    const params = { session: {
      user_id: id,
      password: password
    }}
    return instance.post('/signin', params)
  },
  signout() {
    return instance.delete('/signout')
  }
}