//ユーザー情報を扱うためのReducerクラス

//stateの初期値
const initialState = {
  id: '',
  name: '',
  role: '',
  password: '',
  isInputForm: true,
  isRoleButtons: false,
  isConfirmLanguage: false,
  isUserData: false,
  isConfirmUserData: false
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
  case 'ENABLE_CONFIRM_LANGUAGE_RADIO':
    return Object.assign({}, state, { isConfirmLanguage: true })
  case 'DISABLE_CONFIRM_LANGUAGE_RADIO':
    return Object.assign({}, state, { isConfirmLanguage: false })
  case 'ADD_USER_ROLE':
    return Object.assign({}, state, {
      role: action.role,
      isPasswordForm: true,
      isRoleButtons: false,
      isConfirmLanguage: false
    })
  case 'ADD_USER_PASSWORD':
    return Object.assign({}, state, { 
      password: action.password,
      isPasswordForm: false,
      isConfirmUserData: true,
      isUserData: true
    })
  default:
    return state
  }
}

export default userData