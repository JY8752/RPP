//anime.jsのラッパー
import anime from 'animejs'

export function attackAnime(target) {
  anime({
    targets: target,
    translateY: [10, -10],
    direction: 'alternate',
    loop: 3,
    duration: 200,
    keyframes: [
      { opacity: .2 },
      { opacity: 1 }
    ],
    easing: 'easeInQuad'
  })
}

export function damageAnime() {
  anime({
    targets: 'body',
    translateY: [10, 0],
    direction: 'alternate',
    loop: 3,
    duration: 200,
    easing: 'easeInQuad'
  })
}