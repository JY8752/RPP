//ユーザー情報リストを管理するためのActionクラス

module.exports = {
  getUserList
}

function getUserList() {
  return { type: 'GET_USER_LIST' }
}