
window.onload = ->
  # entry pointi
  game = new window.Game()
  startBtn = document.getElementById "start-btn"
  startBtn.onclick = ->
    menuScene = document.getElementById "menu"
    menuScene.classList.add 'hidden'
    game.initGame()

  restartBtn = document.getElementById "restart-btn"
  restartBtn.onclick = ->
    menuScene = document.getElementById "gameover"
    menuScene.classList.add 'hidden'
    game.initGame()
    
  return
