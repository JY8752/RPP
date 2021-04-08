//つづきから画面におけるactionクラス

module.exports = {
  inputPassword,
  reset,
  successAuthentication
}

function inputPassword(id) {
  return { type: 'INPUT_PASSWORD', id: id }
}

function reset() {
  return { type: 'RESET' }
}

function successAuthentication() {
  return { type: 'SUCCESS_AUTHENTICATION' }
}