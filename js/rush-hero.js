window.Hero = (function() {
  var Hero, p;
  Hero = function() {
    return this.initialize();
  };
  p = Hero.prototype = new window.MovableGameObject();
  p.MovableGameObject_intialize = p.initialize;
  p.initialize = function() {
    var data;
    this.MovableGameObject_intialize();
    this.category = 'hero';
    this.width = 10;
    this.height = 16;
    this.regX = this.width / 2;
    this.regY = this.height;
    data = new createjs.SpriteSheet({
      images: ["images/running.png"],
      frames: {
        regY: -2,
        height: 16,
        width: 16
      },
      animations: {
        "run": [0, 3]
      },
      framerate: 20
    });
    this.character = new createjs.Sprite(data, "run");
    this.character.gotoAndPlay();
    this.addChild(this.character);
    this.collisionPoints = [new createjs.Point(this.width / 2, this.height), new createjs.Point(this.width, this.height / 2)];
    createjs.Ticker.addEventListener("tick", (function(evt) {
      if (!evt.paused) {
        return this.velocity.x = 2;
      }
    }).bind(this));
  };
  p.jump = function() {
    return this.velocity.y = -10;
  };
  return Hero;
})();
