//現在ログインしているユーザーの情報を扱うActionクラス

module.exports = {
  registerUser
}

function registerUser(data) {
  return { type: 'REGISTER_USER', data: data }
}