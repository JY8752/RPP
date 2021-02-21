//typed.jsで出力する文字列を変更するためのReducer

//初期値　なまえ入力画面で出力する文字列
const enterNameWords = [
    'ぼうけんの書をあらたに作成します。',
    'あなたのなまえを入力してください。'
]

//言語選択の画面で出力する文字列
const selectLanguageWords = [
    'あなたの職業はプログラマーです。', 'あなたが興味のある言語をえらんでください。'
]

//言語説明画面で出力する文字列

//あいことば入力画面で出力する文字列
const enterPasswordWords = [
    'さいごにぼうけんを再開するためのあいことばを入力してください。'
]

//ぼうけんの書作成の最終確認
const confirmUserDataWords = [
    'この内容でぼうけんの書を作成します。よろしいですか？'
]


const strings = (state = { words: [] }, action) => {
    switch(action.type) {
        case 'RESET':
            return Object.assign({}, state, { words: []})
        case 'CHANGE_STRINGS':
            return Object.assign({}, state, { words: action.strings })
        case 'ENTER_NAME_STRINGS':
            return Object.assign({}, state, { words: enterNameWords })
        case 'SELECT_LANGUAGE_STRINGS':
            return Object.assign({}, state, { words: selectLanguageWords })
        case 'ENTER_PASSWORD_STRINGS':
            return Object.assign({}, state, { words: enterPasswordWords })
        case 'CONFIRM_USER_DATA_STRINGS':
            return Object.assign({}, state, { words: confirmUserDataWords })
        default:
            return state
    }
}

export default strings