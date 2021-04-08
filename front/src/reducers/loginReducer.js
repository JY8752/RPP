//スタート画面におけるstate更新を行うReducerクラス

//初期値
const initialState = {
  isStart: true,
  isNewGame: false,
  isContinueGame: false
}

const login = (state = initialState, action) => {
  const { type } = action

  switch(type) {
  case 'RESET':
    return initialState
  case 'NEW_GAME':
    return Object.assign({}, state, {
      isStart: false,
      isNewGame: true,
      isContinueGame: false
    })
  case 'CONTINUE_GAME':
    return Object.assign({}, state, {
      isStart: false,
      isNewGame: false,
      isContinueGame: true
    })
  default:
    return state
  }
}

export default login