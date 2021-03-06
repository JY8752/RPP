//ユーザー情報リストを扱うためのReducerクラス

const userDataList = (state = { users: [] }, action) => {
  switch(action.type) {
  case 'GET_USER_LIST':
    return Object.assign({}, state, { users: action.users })
  default:
    return state
  }
}

export default userDataList