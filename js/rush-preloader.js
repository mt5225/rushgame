window.Preloader = (function() {
  var Preloader;
  Preloader = function(game) {
    var bg;
    console.log("preloading images ...");
    this.game = game;
    this.cWidth = game.stage.canvas.width;
    this.cHeight = game.stage.canvas.height;
    bg = new createjs.Shape();
    bg.graphics.beginFill("#000");
    bg.graphics.rect(0, 0, this.cWidth, this.cHeight);
    this.addChild(bg);
    this.progressBar = new createjs.Shape();
    this.progressBar.graphics.beginFill("#333");
    this.addChild(this.progressBar);
    this.percentageText = new createjs.Text("Loading ... 0", "32px sans-serif", "#999");
    this.percentageText.x = this.cWidth / 2;
    this.percentageText.y = this.cHeight / 2;
    this.percentageText.textAlign = "center";
    this.percentageText.textBaseline = "middle";
    this.addChild(this.percentageText);
  };
  Preloader.prototype = new createjs.Container;
  Preloader.prototype.updateProgress = function(percentage) {
    this.progressBar.graphics.rect(0, 0, percentage * this.cWidth, this.cHeight);
    this.percentageText.text = "Loading " + Math.round(percentage * 100) + "%";
    return this.game.stage.update();
  };
  Preloader.prototype.loadGraphics = function() {
    var i, imagesList, img, item, len, loadFiles, results;
    imagesList = [
      {
        name: "coin",
        path: "images/coin.png"
      }, {
        name: "obstacle",
        path: "images/obstacle.png"
      }, {
        name: "platform",
        path: "images/platform.png"
      }, {
        name: "platformLeft",
        path: "images/platform-left.png"
      }, {
        name: "platformRight",
        path: "images/platform-right.png"
      }, {
        name: "platformMiddle",
        path: "images/platform-middle.png"
      }, {
        name: "hero",
        path: "images/running.png"
      }, {
        name: "trees",
        path: "images/trees.png"
      }
    ];
    loadFiles = 0;
    window.graphics = {};
    results = [];
    for (i = 0, len = imagesList.length; i < len; i++) {
      item = imagesList[i];
      img = new Image();
      img.onload = (function(evt) {
        var menuScene, percentage;
        loadFiles++;
        percentage = loadFiles / imagesList.length;
        console.log(evt.target.src + " loaded, progress=" + percentage);
        this.updateProgress(percentage);
        if (loadFiles >= imagesList.length) {
          console.log("all image loaded, go to main stage");
          this.game.stage.removeChild(this);
          menuScene = document.getElementById("menu");
          return menuScene.classList.remove('hidden');
        }
      }).bind(this);
      console.log("loading " + item.path);
      img.src = item.path;
      results.push(window.graphics[item.name] = item);
    }
    return results;
  };
  return Preloader;
})();
