###############
# Movable Object Class
###############

window.MovableGameObject = do ->
  MovableGameObject = ->
    @initialize()

  p = MovableGameObject.prototype = new window.GameObject()
  p.GameObject_initialize = p.initialize

  p.initialize = ->
    @GameObject_initialize()
    @velocity = new createjs.Point(0, 0) #object speed
    @dropSpeed = 1 #gravity
    @onGroud = false

    #create ticker
    createjs.Ticker.setFPS(40)
    createjs.Ticker.addEventListener "tick", ((evt)-> #apply gravity
      if !evt.paused and !@onGroud
        @velocity.y += @dropSpeed
        @velocity.y = Math.min(@velocity.y, 5)
    ).bind(@)
    return

  MovableGameObject
