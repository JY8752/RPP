//バトル画面における情報を管理するためのActionクラス
module.exports = {
  addEnemy,
  addBattleUser
}

function addEnemy(data) {
  return { type: 'ADD_ENEMY', data: data }
}

function addBattleUser(data) {
  return { type: 'ADD_BATTLE_USER', data: data }
}