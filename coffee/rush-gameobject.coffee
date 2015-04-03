#############
# Game Object Class
############

window.GameObject = do ->
  GameObject = ->
    @initialize()
    return

  p = GameObject.prototype = new createjs.Container()

  p.Container_initialize = p.initialize

  p.initialize = ->
    @Container_initialize()
    @category = 'object'
    @width = 0
    @height = 0
    return

  p.hit = (point) ->
    if(point.x >=0 && point.x <= @width && point.y >= 0 && point.y <= @height)
      true
    else
      false

  GameObject
