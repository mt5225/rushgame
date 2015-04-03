###################
# platform class
##################

window.Platform = do ->
  Platform = (width) ->
    @initialize width
    return

  p = Platform.prototype = new (window.GameObject)()
  p.category = 'platform'
  p.GameObject_initialize = p.initialize

  p.initialize = (width) ->
    @width = width or 120
    @height = 12
    # draw a shape to represent the platform.
    shape = window.CommonShapes.rectangle(
      width: @width
      height: @height)
    @addChild shape
    return

  Platform
