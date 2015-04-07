##############################################
# Image preloader
##############################################
window.Preloader = do ->
  Preloader = (game)->
    console.log "preloading images ..."
    @game = game
    @cWidth = game.stage.canvas.width
    @cHeight= game.stage.canvas.height
    bg = new createjs.Shape()
    bg.graphics.beginFill "#000"
    bg.graphics.rect 0,0, @cWidth, @cHeight
    @addChild bg
    @progressBar = new createjs.Shape()
    @progressBar.graphics.beginFill "#333"
    @addChild @progressBar
    @percentageText = new createjs.Text "Loading ... 0", "32px sans-serif", "#999"
    @percentageText.x =  @cWidth / 2
    @percentageText.y =  @cHeight / 2
    @percentageText.textAlign = "center"
    @percentageText.textBaseline = "middle"
    @addChild @percentageText
    return

  Preloader.prototype = new createjs.Container

  Preloader.prototype.updateProgress = (percentage) ->
    @progressBar.graphics.rect 0,0, percentage*@cWidth, @cHeight
    @percentageText.text = "Loading " + Math.round(percentage * 100) + "%"
    @game.stage.update()

  Preloader.prototype.loadGraphics = ->
    imagesList = [
      {name:"coin", path:"images/coin.png"},
      {name:"obstacle", path:"images/obstacle.png"},
      {name:"platform", path:"images/platform.png"},
      {name:"platformLeft", path:"images/platform-left.png"},
      {name:"platformRight", path:"images/platform-right.png"},
      {name:"platformMiddle", path:"images/platform-middle.png"},
      {name:"hero", path:"images/running.png"},
      {name:"trees", path:"images/trees.png"},
    ]
    loadFiles = 0
    window.graphics = {}
    for item in imagesList
      img = new Image()
      img.onload = ((evt)-> #register load event
        loadFiles++
        percentage = loadFiles / imagesList.length
        console.log "#{evt.target.src} loaded, progress=#{percentage}"
        @updateProgress percentage
        if loadFiles >= imagesList.length #done loading, show the menu
          console.log "all image loaded, go to main stage"
          @game.stage.removeChild @
          menuScene = document.getElementById "menu"
          menuScene.classList.remove 'hidden'
      ).bind(@)
      console.log "loading #{item.path}"
      img.src = item.path  #load the image
      window.graphics[item.name] = item

  Preloader
