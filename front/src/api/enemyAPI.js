import instance from './index.js'

export default {
  getEnemy(stageId) {
    return instance.get(`/enemies/${stageId}`)
  }
}