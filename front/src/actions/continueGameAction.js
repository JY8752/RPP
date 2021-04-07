//つづきから画面におけるactionクラス

module.exports = {
  inputPassword,
  reset
}

function inputPassword() {
  return { type: 'INPUT_PASSWORD' }
}

function reset() {
  return { type: 'RESET' }
}