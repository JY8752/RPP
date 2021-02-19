// typed.jsで出力する文字列を管理するためのactionクラス

module.exports = {
    reset,
    changeStrings
}

function reset() {
    return { type: 'RESET'}
}

function changeStrings(words) {
    return { type: 'CHANGE_STRINGS', strings: words }
}