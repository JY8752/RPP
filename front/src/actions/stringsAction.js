// typed.jsで出力する文字列を管理するためのactionクラス

module.exports = {
  reset,
  changeStrings,
  enterNameStrings,
  selectLanguageStrings,
  enterPasswordStrings,
  confirmUserDataStrings,
  createdUserStrings,
  inputPasswordStrings,
  successAuthenticationStrings,
  homeStrings
}

function reset() {
  return { type: 'RESET'}
}

function changeStrings(words) {
  return { type: 'CHANGE_STRINGS', strings: words }
}

function enterNameStrings() {
  return { type: 'ENTER_NAME_STRINGS' }
}

function selectLanguageStrings() {
  return { type: 'SELECT_LANGUAGE_STRINGS' }
}

function enterPasswordStrings() {
  return { type: 'ENTER_PASSWORD_STRINGS' }
}

function confirmUserDataStrings() {
  return { type: 'CONFIRM_USER_DATA_STRINGS' }
}

function createdUserStrings() {
  return { type: 'CREATED_USER_STRINGS' }
}

function inputPasswordStrings() {
  return { type: 'INPUT_PASSWORD_STRINGS' }
}

function successAuthenticationStrings() {
  return { type: 'SUCCESS_AUTHENTICATION_STRINGS' }
}

function homeStrings() {
  return { type: 'HOME_STRINGS' }
}