//typed.jsで出力する文字列を変更するためのReducer

const strings = (state = { words: [] }, action) => {
    switch(action.type) {
        case 'RESET':
            return Object.assign({}, state, { words: []})
        case 'CHANGE_STRINGS':
            return Object.assign({}, state, { words: action.strings })
        default:
            return state
    }
}

export default strings