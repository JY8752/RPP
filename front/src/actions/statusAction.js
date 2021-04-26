module.exports = {
  addUserStatus
}

function addUserStatus(data) {
  return { type: 'ADD_USER_STATUS', status: data}
}