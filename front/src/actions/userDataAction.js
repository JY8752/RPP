// ユーザー情報を管理するためのActionクラス

module.exports = {
    reset,
    addUserId,
    addUserName,
    addUserRole,
    addUserPassword,
    disableConfirmLanguageRadio,
    enableConfirmLanguageRadio
}

//stateの初期値
const initialState = {
    id: '',
    name: '',
    role: '',
    password: '',
    isInputForm: true,
    isRoleButtons: false,
    isConfirmLanguage: false,
    isPasswordForm: false,
    isUserData: false,
    isConfirmUserData: false
}

function reset() {
    return { type: 'RESET', initialState }
}

function addUserId(id) {
    return { type: 'ADD_USER_ID', id: id }
}

function addUserName(name) {
    return { type: 'ADD_USER_NAME', name: name }
}

function addUserRole(role) {
    return { type: 'ADD_USER_ROLE', role: role }
}

function addUserPassword(password) {
    return { type: 'ADD_USER_PASSWORD', password: password }
}

function enableConfirmLanguageRadio() {
    return { type: 'ENABLE_CONFIRM_LANGUAGE_RADIO'}
}

function disableConfirmLanguageRadio() {
    return { type: 'DISABLE_CONFIRM_LANGUAGE_RADIO'}
}