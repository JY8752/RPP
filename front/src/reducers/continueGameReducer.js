//つづきから画面のstateを更新するためのReduer

const initialState = {
  isInputPassword: false
}

const continueGame = (state = initialState, action) => {
  const { type } = action
  switch(type) {
  case 'INPUT_PASSWORD':
    return Object.assign({}, state, { isInputPassword: true })
  case 'RESET':
    return initialState
  default:
    return state
  }
}

export default continueGame

