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
    # draw a shape to represent the coin.
    shape = window.CommonShapes.rectangle(
      width: @width
      height: @height
      fillColor: "#ff0")
    @addChild shape
    @regX = @width / 2
    @regY = @height
    return

  Coin
