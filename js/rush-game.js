window.Game = (function() {
  var RushGame, p;
  RushGame = function() {
    var bgImage, preloader;
    console.log('Rush game starts.');
    this.canvas = document.getElementById('game-canvas');
    this.scoreHud = document.getElementById('score');
    this.stage = new createjs.Stage(this.canvas);
    this.bg = new createjs.Container;
    bgImage = new createjs.Bitmap('images/trees.png');
    this.bg.addChild(bgImage);
    this.stage.addChild(this.bg);
    this.camera = new createjs.Container;
    this.stage.addChild(this.camera);
    createjs.Ticker.setFPS(40);
    preloader = new window.Preloader(this);
    this.stage.addChild(preloader);
    preloader.loadGraphics();
  };
  p = RushGame.prototype;
  p.initGame = function() {
    var coin, i, j, lastPlatformX, lastPlatformY, obstacle, platform, platformGap, width;
    console.log('reset and init');
    this.resetGame();
    this.hero = new window.Hero;
    this.hero.x = 100;
    this.hero.y = 100;
    this.collectedCoins = 0;
    this.camera.addChild(this.hero);
    this.stage.on("stagemousedown", (function(evt) {
      if (this.hero.onGroud) {
        return this.hero.jump();
      }
    }).bind(this));
    lastPlatformX = 50;
    lastPlatformY = 150;
    for (i = j = 1; j < 10; i = ++j) {
      width = 120 + Math.round(Math.random() * 20);
      platform = new window.Platform(width);
      platform.x = lastPlatformX;
      platform.y = Math.random() * 80 - 40 + lastPlatformY;
      platform.y = Math.max(80, Math.min(250, platform.y));
      platformGap = Math.max(Math.random() * 32, 20);
      lastPlatformX += platform.width + platformGap;
      lastPlatformY = platform.y;
      this.camera.addChild(platform);
      if (Math.random() > 0.5 && i > 1) {
        obstacle = new window.Obstacle();
        obstacle.x = platform.x + platform.width / 2;
        obstacle.y = platform.y;
        this.camera.addChild(obstacle);
      } else {
        coin = new window.Coin();
        coin.x = platform.x + platform.width / 2;
        coin.y = platform.y;
        this.camera.addChild(coin);
      }
    }
  };
  p.gameObjectHitHero = function(category, hitCallBack) {
    var collisionPoint, j, len, obj, point, ref, results;
    ref = this.camera.children;
    results = [];
    for (j = 0, len = ref.length; j < len; j++) {
      obj = ref[j];
      if (obj && obj.category === category) {
        results.push((function() {
          var k, len1, ref1, results1;
          ref1 = this.hero.collisionPoints;
          results1 = [];
          for (k = 0, len1 = ref1.length; k < len1; k++) {
            collisionPoint = ref1[k];
            point = this.hero.localToLocal(collisionPoint.x, collisionPoint.y, obj);
            if (obj.hit(point)) {
              results1.push(hitCallBack(point, obj));
            } else {
              results1.push(void 0);
            }
          }
          return results1;
        }).call(this));
      }
    }
    return results;
  };
  p.resolveCollision = function() {
    this.hero.onGroud = false;
    this.gameObjectHitHero('platform', (function(point, platform) {
      if (this.hero.velocity.y > 0) {
        this.hero.y = platform.y;
        this.hero.velocity.y = 0;
      }
      return this.hero.onGroud = true;
    }).bind(this));
    this.gameObjectHitHero('obstacle', (function(point, gameObject) {
      console.log("===> hit obstacle");
      return this.gameOver();
    }).bind(this));
    return this.gameObjectHitHero('coin', (function(point, coin) {
      console.log("===> hit coin");
      this.camera.removeChild(coin);
      return this.collectedCoins++;
    }).bind(this));
  };
  p.moveGameObject = function() {
    var gameObject, j, len, ref;
    ref = this.camera.children;
    for (j = 0, len = ref.length; j < len; j++) {
      gameObject = ref[j];
      if (!gameObject.velocity) {
        continue;
      }
      gameObject.x += gameObject.velocity.x;
      gameObject.y += gameObject.velocity.y;
    }
    if (this.hero.y > 400) {
      return this.gameOver();
    }
  };
  p.moveCamera = function() {
    return this.camera.x -= this.hero.velocity.x;
  };
  p.gameOver = function() {
    var gameOverScene, tc, tch, yourScore;
    createjs.Ticker.setPaused(true);
    gameOverScene = document.getElementById("gameover");
    gameOverScene.classList.remove('hidden');
    yourScore = document.getElementById('your-game-score');
    yourScore.innerHTML = "You game score : " + this.collectedCoins;
    localStorage['highScore'] = localStorage['highScore'] || 0;
    localStorage['highScore'] = Math.max(localStorage['highScore'], this.collectedCoins);
    yourScore.innerHTML += "<br> highest score: " + localStorage['highScore'];
    tc = new window.TopScores();
    tc.saveScore(this.collectedCoins);
    tch = document.getElementById('top-scores');
    return tch.innerHTML = tc.toHtml();
  };
  p.resetGame = function() {
    createjs.Ticker.removeAllEventListeners();
    this.camera.removeAllChildren();
    this.camera.x = 0;
    createjs.Ticker.setPaused(false);
    return createjs.Ticker.addEventListener("tick", (function(evt) {
      if (!evt.paused) {
        this.updateView();
        this.resolveCollision();
        this.moveGameObject();
        return this.moveCamera();
      }
    }).bind(this));
  };
  p.updateView = function() {
    this.stage.update();
    return this.scoreHud.innerHTML = this.collectedCoins;
  };
  return RushGame;
})();
