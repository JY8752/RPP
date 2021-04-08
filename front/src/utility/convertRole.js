//ロールが整数で返ってくるので変換する

const convert = (roleNum) => {
  switch(roleNum) {
  case 0:
    return 'Javaプログラマー'
  case 1:
    return 'Rubyプログラマー'
  case 2:
    return 'Rustプログラマー'
  default:
    return 'フリーランス'
  }
}

export default convert