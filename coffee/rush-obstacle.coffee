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
    @width = 40
    @height = 20
    # draw a shape to represent the obstacle.
    shape = window.CommonShapes.rectangle(
      width: @width
      height: @height
      fillColor: "#f00")
    @addChild shape
    @regX = @width / 2
    @regY = @height
    return

  Obstacle
