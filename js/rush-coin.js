window.Coin = (function() {
  var Coin, p;
  Coin = function() {
    this.initialize();
  };
  p = Coin.prototype = new window.GameObject();
  p.category = 'coin';
  p.GameObject_initialize = p.initialize;
  p.initialize = function() {
    var data;
    this.width = 10;
    this.height = 10;
    this.regX = this.width / 2;
    this.regY = this.height;
    data = new createjs.SpriteSheet({
      images: ["images/coin.png"],
      frames: {
        height: 16,
        width: 16
      },
      animations: {
        "all": [0, 3]
      },
      framerate: 20
    });
    this.animation = new createjs.Sprite(data, "all");
    this.animation.gotoAndPlay();
    this.addChild(this.animation);
  };
  return Coin;
})();
