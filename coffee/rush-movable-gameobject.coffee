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
    #TODO moving logic later

  MovableGameObject
