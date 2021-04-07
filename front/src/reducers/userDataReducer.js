//ユーザー情報を扱うためのReducerクラス

//stateの初期値
const initialState = {
  id: null,
  name: '',
  role: '',
  level: null,
  password: '',
  isInputForm: true,
  isRoleButtons: false,
  isConfirmLanguage: false,
  isUserData: false,
  isConfirmUserData: false,
  isCreated: false
}


const userData = (state = { users: initialState }, action) => {
  switch(action.type) {
  case 'RESET':
    return initialState
  case 'ADD_USER':
    return Object.assign({}, state, {
      id: action.userData.id,
      name: action.userData.name,
      role: action.userData.role,
      level: action.userData.level
    })
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
  case 'CREATED_USER':
    return Object.assign({}, state, {
      isUserData: false,
      isConfirmUserData: false,
      isCreated: true
    })
  default:
    return state
  }
}

export default userData