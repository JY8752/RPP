const userStatus = (state = {}, action) => {
  const { type, status } = action
  switch(type) {
  case 'ADD_USER_STATUS':
    return status
  default:
    return state
  }
}

export default userStatus