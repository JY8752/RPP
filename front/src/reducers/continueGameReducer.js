//つづきから画面のstateを更新するためのReduer

const initialState = {
  id: null,
  isUserList: true,
  isInputPassword: false,
  isSuccessAuthentication: false
}

const continueGame = (state = initialState, action) => {
  const { type, id } = action
  switch(type) {
  case 'INPUT_PASSWORD':
    return Object.assign({}, state, { 
      id: id,
      isUserList: false,
      isInputPassword: true 
    })
  case 'RESET':
    return initialState
  case 'SUCCESS_AUTHENTICATION':
    return Object.assign({}, state, {
      isUserList: false,
      isInputPassword: false,
      isSuccessAuthentication: true
    })
  default:
    return state
  }
}

export default continueGame

