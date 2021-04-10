import { combineReducers } from 'redux'
import userDataList from './userDataListReducer'
import userData from './userDataReducer'
import strings from './stringsReducer'
import continueGame from './continueGameReducer'
import login from './loginReducer'
import currentUserData from './currentUserDataReducer'

export default combineReducers({
  userDataList,
  userData,
  strings,
  continueGame,
  login,
  currentUserData
})