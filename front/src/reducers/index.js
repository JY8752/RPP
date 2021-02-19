import { combineReducers } from 'redux'
import userDataList from './userDataListReducer'
import userData from './userDataReducer'
import strings from './stringsReducer'

export default combineReducers({
    userDataList,
    userData,
    strings
})