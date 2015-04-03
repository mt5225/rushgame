#############
# Game Object Class
############

window.GameObject = do ->
  GameObject = ->
    @initialize()
    return

  p = GameObject.prototype = new createjs.Container()
  p.category = 'object'
  p.width = 0
  p.height = 0
  p.Container_initialize = p.initialize

  p.initialize = ->
    @Container_initialize()

  GameObject
