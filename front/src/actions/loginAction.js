//スタート画面におけるActionクラス

module.exports = {
  reset,
  newGame,
  continueGame
}

function reset() {
  return { type: 'RESET' }
}

function newGame() {
  return { type: 'NEW_GAME' }
}

function continueGame() {
  return { type: 'CONTINUE_GAME' }
}