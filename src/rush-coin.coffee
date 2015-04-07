###################
#Coin class
##################

window.Coin = do ->
  Coin = ->
    @initialize()
    return

  p = Coin.prototype = new (window.GameObject)()
  p.category = 'coin'
  p.GameObject_initialize = p.initialize

  p.initialize = ->
    @width = 10
    @height = 10
    @regX = @width / 2
    @regY = @height
    data = new createjs.SpriteSheet {
      images: ["images/coin.png"],
      frames: {height: 16, width: 16},
      animations: {"all": [0, 3]},
      framerate: 20
    }
    @animation = new createjs.Sprite(data, "all");
    @animation.gotoAndPlay();
    @addChild @animation

    return

  Coin
