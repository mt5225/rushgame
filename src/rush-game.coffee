#################
# Game Class
################

window.Game = do ->
  RushGame = ->
    console.log 'Rush game starts.'
    @canvas = document.getElementById 'game-canvas'
    @scoreHud = document.getElementById 'score'
    @stage = new createjs.Stage @canvas
    #create background
    @bg = new createjs.Container
    bgImage = new createjs.Bitmap 'images/trees.png'
    @bg.addChild bgImage
    @stage.addChild @bg
    #create camera
    @camera = new createjs.Container
    @stage.addChild @camera

    createjs.Ticker.setFPS 40

    #preload image
    preloader = new window.Preloader @
    @stage.addChild preloader
    preloader.loadGraphics()
    return

  p = RushGame.prototype

  p.initGame = ->
    console.log 'reset and init'
    @resetGame()
    #make hero
    @hero = new window.Hero
    @hero.x = 100
    @hero.y = 100
    @collectedCoins = 0
    @camera.addChild @hero

    #register user input handler
    @stage.on "stagemousedown", ((evt) ->
      @hero.jump() if @hero.onGroud
    ).bind(@)

    #make platform and obstacle
    lastPlatformX = 50
    lastPlatformY = 150
    for i in [1...10]
      width = 120 + Math.round(Math.random() * 20)
      platform = new window.Platform width
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
    return

  #collision check
  p.gameObjectHitHero = (category, hitCallBack) ->
    for obj in @camera.children when obj and obj.category == category
      for collisionPoint in @hero.collisionPoints
        point = @hero.localToLocal(collisionPoint.x, collisionPoint.y, obj)
        hitCallBack(point, obj) if obj.hit(point)

  #for each tick, perform collision checking
  p.resolveCollision = ->
    @hero.onGroud = false
    @gameObjectHitHero 'platform', ((point, platform)-> #hero on platform
      if @hero.velocity.y > 0
        @hero.y = platform.y
        @hero.velocity.y = 0
      @hero.onGroud = true
    ).bind(@)

    @gameObjectHitHero 'obstacle', ((point, gameObject)-> #hero hit obstacle
      console.log "===> hit obstacle"
      @gameOver()
    ).bind(@)

    @gameObjectHitHero 'coin', ((point, coin)-> #hero hit coin
      console.log "===> hit coin"
      @camera.removeChild coin
      @collectedCoins++
    ).bind(@)

  p.moveGameObject = ->
    for gameObject in @camera.children when gameObject.velocity
      gameObject.x += gameObject.velocity.x
      gameObject.y += gameObject.velocity.y
    @gameOver() if @hero.y > 400

  p.moveCamera = ->
    @camera.x -= @hero.velocity.x

  p.gameOver = ->
    createjs.Ticker.setPaused true
    gameOverScene = document.getElementById "gameover"
    gameOverScene.classList.remove 'hidden'
    yourScore = document.getElementById 'your-game-score'
    yourScore.innerHTML = "You game score : #{@collectedCoins}"
    localStorage['highScore'] = localStorage['highScore'] or 0
    localStorage['highScore'] = Math.max localStorage['highScore'], @collectedCoins
    yourScore.innerHTML += "<br> highest score: #{localStorage['highScore']}"
    tc = new window.TopScores()
    tc.saveScore @collectedCoins
    tch = document.getElementById 'top-scores'
    tch.innerHTML = tc.toHtml()

  p.resetGame = ->
    createjs.Ticker.removeAllEventListeners()
    @camera.removeAllChildren()
    @camera.x = 0
    createjs.Ticker.setPaused false
    #add tick listner
    createjs.Ticker.addEventListener "tick", ((evt)->
      if(!evt.paused)
        @updateView()
        @resolveCollision()
        @moveGameObject()
        @moveCamera()
    ).bind(@)

  p.updateView = ->
    @stage.update()
    @scoreHud.innerHTML = @collectedCoins

  RushGame
