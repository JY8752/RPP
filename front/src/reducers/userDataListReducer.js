//ユーザー情報リストを扱うためのReducerクラス

//stateの初期値
const initialState =[
    {id: 1, name: 'testName1', role: 'java-programer', revel: 1},
    {id: 2, name: 'testName2', role: 'ruby-programer', revel: 2},
    {id: null, name: null, role: null, revel: null}
] 


const userDataList = (state = { users: initialState }, action) => {
    switch(action.type) {
        case 'ACTION':
            //TODO
        default:
            return state
    }
}

export default userDataList