#################
# Game Class
################

window.Game = do ->
  RushGame = ->
    console.log 'Rush game starts.'
    @canvas = document.getElementById('game-canvas')
    @stage = new createjs.Stage(@canvas)

    @camera = new createjs.Container()
    @stage.addChild(@camera)
    createjs.Ticker.setFPS(40)
    @initGame()
    return

  p = RushGame.prototype

  p.initGame = ->
    #make hero
    @hero = new (window.Hero)()
    @hero.x = 100
    @hero.y = 100
    @collectedCoin = 0
    @camera.addChild @hero

    #register user input handler
    @stage.on "stagemousedown", ((evt) ->
      @hero.jump() if @hero.onGroud
    ).bind(@)

    #make platform and obstacle
    lastPlatformX = 50
    lastPlatformY = 150
    for i in [1...10]
      platform = new (window.Platform)()
      platform.x = lastPlatformX
      platform.y = Math.random()*80 - 40 + lastPlatformY
      platform.y = Math.max(80, Math.min(250, platform.y))
      platformGap = Math.max(Math.random() * 32, 20)
      lastPlatformX += platform.width + platformGap
      lastPlatformY = platform.y
      @camera.addChild platform
      #place obstacle on platform
      if Math.random() > 0.5 and i > 1
        obstacle = new (window.Obstacle)()
        obstacle.x = platform.x + platform.width /2
        obstacle.y = platform.y
        @camera.addChild obstacle
      else
        coin = new (window.Coin)()
        coin.x = platform.x + platform.width /2
        coin.y = platform.y
        @camera.addChild coin

    #add tick listner
    createjs.Ticker.addEventListener "tick", ((evt)->
      if(!evt.paused)
        @updateView()
        @resolveCollision()
        @moveGameObject()
        @moveCamera()
    ).bind(@)

    return

  #collision check
  p.gameObjectHitHero = (category, hitCallBack) ->
    for gameObject in @camera.children when gameObject and gameObject.category == category
      for collisionPoint in @hero.collisionPoints
        point = @hero.localToLocal(collisionPoint.x, collisionPoint.y, gameObject)
        hitCallBack(point, gameObject) if gameObject.hit(point)

  #for each tick, perform collision checking
  p.resolveCollision = ->
    @hero.onGroud = false
    @gameObjectHitHero 'platform', ((point, platform)-> #on platform
      if @hero.velocity.y > 0
        @hero.y = platform.y
        @hero.velocity.y = 0
      @hero.onGroud = true
    ).bind(@)

    @gameObjectHitHero 'obstacle', ((point, gameObject)-> #hit obstacle
      @gameOver()
    ).bind(@)

    @gameObjectHitHero 'coin', ((point, coin)-> #hit coin
      @camera.removeChild coin
      @collectedCoin++
    ).bind(@)

  p.moveGameObject = ->
    for gameObject in @camera.children when gameObject.velocity #move everything have velocity
      gameObject.x += gameObject.velocity.x
      gameObject.y += gameObject.velocity.y
    @gameOver() if @hero.y > 400

  p.moveCamera = ->
    @camera.x -= @hero.velocity.x

  p.gameOver = ->
    @resetGame()
    @initGame()

  p.resetGame = ->
    createjs.Ticker.removeAllEventListeners()
    @camera.removeAllChildren()
    @camera.x = 0

  p.updateView = ->
    @stage.update()

  RushGame
