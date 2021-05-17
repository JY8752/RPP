//バトル画面におけるstateを更新するReducerクラス

//初期state
const init = {
  user: {
    hp: 0,
    mp: 0,
    attack: 0,
    defence: 0,
    next_level_point: 0
  },
  enemy: {
    name: '',
    hp: 0,
    action_pattern: {},
    action_pattern_index: 0,
    experience_point: 0
  }
}

const battleData = (state = init, action) => {
  const { type, data } = action

  switch(type) {
  case 'ADD_ENEMY':
    return Object.assign({}, state, {
      enemy: {
        name: data.name,
        hp: data.hp,
        action_pattern: data.action_pattern,
        action_pattern_index: 0,
        experience_point: data.experience_point
      }
    })
  case 'ADD_BATTLE_USER':
    return Object.assign({}, state, {
      user: {
        hp: data.hp,
        mp: data.mp,
        attack: data.attack,
        defence: data.defence,
        next_level_point: data.next_level_point
      }
    })
  default:
    return state
  }
}

export default battleData