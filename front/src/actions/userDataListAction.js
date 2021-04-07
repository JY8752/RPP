//ユーザー情報リストを管理するためのActionクラス

module.exports = {
  getUserList
}

function getUserList(users) {
  return { type: 'GET_USER_LIST', users: users }
}