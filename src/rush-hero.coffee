##################
# Hero Class
#################

window.Hero = do ->
  Hero = ->
    @initialize()

  p = Hero.prototype = new window.MovableGameObject()
  p.MovableGameObject_intialize = p.initialize

  p.initialize = ->
    @MovableGameObject_intialize()
    @category = 'hero'
    @width = 10
    @height = 16
    @regX = @width / 2
    @regY = @height

    data = new createjs.SpriteSheet {
      images: ["images/running.png"],
      frames: {regY: -2, height: 16, width: 16},
      animations: {"run": [0, 3]},
      framerate: 20
    }
    @character = new createjs.Sprite(data, "run");
    @character.gotoAndPlay();
    @addChild @character


    @collisionPoints = [
      new createjs.Point(@width/2, @height),
      new createjs.Point(@width, @height/2)
    ]

    #create ticker
    createjs.Ticker.addEventListener "tick", ((evt)->
      if !evt.paused
        @velocity.x = 2
    ).bind(@)
    return

  p.jump = ->
    @velocity.y = -10

  Hero
