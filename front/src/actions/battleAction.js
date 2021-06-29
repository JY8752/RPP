//バトル画面における情報を管理するためのActionクラス
module.exports = {
  addEnemy,
  addBattleUser,
  updateBattleResult
}

function addEnemy(data) {
  return { type: 'ADD_ENEMY', data: data }
}

function addBattleUser(data) {
  return { type: 'ADD_BATTLE_USER', data: data }
}

function updateBattleResult(userLife, enemyLife, actionIndex) {
  return { type: 'UPDATE_BATTLE_RESULT', data: {
    userLife: userLife,
    enemyLife: enemyLife,
    actionIndex: actionIndex
  }}
}