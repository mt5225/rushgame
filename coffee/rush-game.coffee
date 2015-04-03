#################
# Game Class
################

window.Game = do ->
  RushGame = ->
    console.log 'Rush game starts.'
    @canvas = document.getElementById('game-canvas')
    # EaselJS Stage
    @stage = new (createjs.Stage)(@canvas)
    @initGame()
    return

  p = RushGame.prototype

  p.initGame = ->
    #make platform and obstacle
    lastPlatformX = 50
    lastPlatformY = 150
    for i in [1...10]
      platform = new (window.Platform)()
      platform.x = lastPlatformX
      platform.y = Math.random()*80 - 40 + lastPlatformY
      platform.y = Math.max(80, Math.min(250, platform.y))
      platformGap = Math.random() * 32
      lastPlatformX += platform.width + platformGap
      lastPlatformY = platform.y
      @stage.addChild platform
      #place obstacle on platform
      if Math.random() > 0.5 and i > 1
        obstacle = new (window.Obstacle)()
        obstacle.x = platform.x + platform.width /2
        obstacle.y = platform.y
        @stage.addChild obstacle
      else
        coin = new (window.Coin)()
        coin.x = platform.x + platform.width /2
        coin.y = platform.y
        @stage.addChild coin


    #make hero
    @hero = new (window.Hero)()
    @hero.x = 100
    @hero.y = 100
    @stage.addChild @hero

    #test for collsion
    platform = new (window.Platform)()
    platform.x = 90
    platform.y = 100
    @stage.addChild platform
    obstacle = new (window.Obstacle)()
    obstacle.x = 120
    obstacle.y = 100
    @stage.addChild obstacle
    coin = new (window.Coin)()
    coin.x = 105
    coin.y = 100
    @stage.addChild coin

    @resolveCollision()
    @updateView()
    return

  #collision check method
  p.gameObjectHitHero = (category, hitCallBack) ->
    for gameObject in @stage.children when gameObject.category == category
      for collisionPoint in @hero.collisionPoints
        point = @hero.localToLocal(collisionPoint.x, collisionPoint.y, gameObject)
        if gameObject.hit(point)
          console.log "=====> hero hit by #{category}"
          hitCallBack()

  p.resolveCollision = ->
    @gameObjectHitHero 'platform', ->
    @gameObjectHitHero 'obstacle', ->
    @gameObjectHitHero 'coin', ->


  p.updateView = ->
    @stage.update()
    return

  RushGame
