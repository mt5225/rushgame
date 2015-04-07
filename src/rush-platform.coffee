###################
# platform class
##################

window.Platform = do ->
  Platform = (width) ->
    @initialize width
    return

  p = Platform.prototype = new window.GameObject
  p.category = 'platform'
  p.GameObject_initialize = p.initialize

  p.initialize = (width) ->
    @width = width or 120
    @height = 12
    if width == 120
      pImg = new createjs.Bitmap('images/platform.png')
      @addChild pImg
    else
      pLeft = new createjs.Bitmap('images/platform-left.png')
      pRight = new createjs.Bitmap('images/platform-right.png')
      pMiddle = new createjs.Bitmap('images/platform-middle.png')
      pMiddle.x = 57
      pMiddle.scaleX = width - 57 - 62
      pRight.x = pMiddle.scaleX + pMiddle.x
      @addChild pLeft
      @addChild pMiddle
      @addChild pRight
      return

  Platform
