//ユーザー情報を扱うためのReducerクラス

//stateの初期値
const initialState = {
    id: '',
    name: '',
    role: '',
    password: '',
    isInputForm: true,
    isRoleButtons: false
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
        default:
            return state
    }
}

export default userData