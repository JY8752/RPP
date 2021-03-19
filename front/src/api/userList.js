import instance from './index.js'

const userList = () => {

  instance
    .get('/users')
    .then(({ data: response }) => {
      console.log(response)
    })
}

export default userList