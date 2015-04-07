###################
#Obstacle class
##################

window.Obstacle = do ->
  Obstacle = ->
    @initialize()
    return

  p = Obstacle.prototype = new (window.GameObject)()
  p.category = 'obstacle'
  p.GameObject_initialize = p.initialize

  p.initialize = ->
    @width = 16
    @height = 12
    @regX = @width / 2
    @regY = @height
    data = new createjs.SpriteSheet {
      images: ["images/obstacle.png"],
      frames: {regY: -4, height: 12, width: 32},
      animations: {"all": [0, 1]},
      framerate: 10 
    }
    ob = new createjs.Sprite(data, "all");
    ob.gotoAndPlay();
    @addChild ob

    return

  Obstacle
