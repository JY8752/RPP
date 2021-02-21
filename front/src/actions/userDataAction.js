// ユーザー情報を管理するためのActionクラス

module.exports = {
    reset,
    addUserId,
    addUserName,
    addUserRole,
    addUserPassword,
    changeConfirmRadio
}

//stateの初期値
const initialState = {
    id: '',
    name: '',
    role: '',
    password: '',
    isInputForm: true,
    isRoleButtons: false,
    isConfirmRadio: false,
    isPasswordForm: false,
    isUserData: false
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

function changeConfirmRadio() {
    return { type: 'CHANGE_CONFIRM_RADIO'}
}