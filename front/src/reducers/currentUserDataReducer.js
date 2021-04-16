//現在ログインしているユーザー情報のstaateを更新する

const currentUserData = (state = {}, action) => {
  const { type, data } = action

  switch(type) {
  case 'REGISTER_USER':
    return data
  default:
    return state
  }
}

export default currentUserData