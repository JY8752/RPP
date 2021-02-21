//ユーザー情報を扱うためのReducerクラス

//stateの初期値
const initialState = {
    id: '',
    name: '',
    role: '',
    password: '',
    isInputForm: true,
    isRoleButtons: false,
    isConfirmRadio: false,
    isUserData: false
}


const userData = (state = { users: initialState }, action) => {
    switch(action.type) {
        case 'RESET':
            return initialState
        case 'ADD_USER_NAME':
            return Object.assign({}, state, { 
                name: action.name,
                isInputForm: false,
                isRoleButtons: true
            })
        case 'CHANGE_CONFIRM_RADIO':
            return Object.assign({}, state, { isConfirmRadio: !state.isConfirmRadio })
        case 'ADD_USER_ROLE':
            return Object.assign({}, state, {
                role: action.role,
                isPasswordForm: true,
                isRoleButtons: false,
                isConfirmRadio: false
            })
        case 'ADD_USER_PASSWORD':
            return Object.assign({}, state, { 
                password: action.password,
                isPasswordForm: false,
                isConfirmRadio: true,
                isUserData: true
            })
        default:
            return state
    }
}

export default userData