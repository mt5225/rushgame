#################
# Game Class
################

window.Game = do ->
  RushGame = ->
    console.log 'Rush game starts.'
    @canvas = document.getElementById('game-canvas')
    # EaselJS Stage
    @stage = new (createjs.Stage)(@canvas)
    @initGame()
    @updateView()
    return

  p = RushGame.prototype
  p.initGame = ->
    platform = new (window.Platform)()
    platform.x = 100
    platform.y = 100
    @stage.addChild platform
    return

  p.updateView = ->
    @stage.update()
    return

  RushGame
