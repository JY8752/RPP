//現在ログインしているユーザー情報のstaateを更新する

const currentUser = (state = {}, action) => {
  const { type, data } = action

  switch(type) {
  case 'REGISTER_USER':
    console.log(data)
    return data
  default:
    return state
  }
}

export default currentUser