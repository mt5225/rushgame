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

    # draw a shape to represent the platform.
    shape = window.CommonShapes.rectangle(
      width: @width
      height: @height
      fillColor: "#0f0"  #green color
      )
    @addChild shape

    @regX = @width / 2
    @regY = @height
    @collisionPoints = [
      new createjs.Point(@width/2, @height),
      new createjs.Point(@width, @height/2)
    ]
    return

  Hero
