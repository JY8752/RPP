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
  },
  getUserStatus(id) {
    return instance.get(`/users/status/${id}`)
  },
  stageClear(id, stageLevel, experiencePoint) {
    const params = {
      result: {
        clear_stage_level: stageLevel,
        get_experience_point: experiencePoint 
      }
    }
    return instance.put(`/users/clear/${id}`, params)
  }
}
