window.Obstacle = (function() {
  var Obstacle, p;
  Obstacle = function() {
    this.initialize();
  };
  p = Obstacle.prototype = new window.GameObject();
  p.category = 'obstacle';
  p.GameObject_initialize = p.initialize;
  p.initialize = function() {
    var data, ob;
    this.width = 16;
    this.height = 12;
    this.regX = this.width / 2;
    this.regY = this.height;
    data = new createjs.SpriteSheet({
      images: ["images/obstacle.png"],
      frames: {
        regY: -4,
        height: 12,
        width: 32
      },
      animations: {
        "all": [0, 1]
      },
      framerate: 10
    });
    ob = new createjs.Sprite(data, "all");
    ob.gotoAndPlay();
    this.addChild(ob);
  };
  return Obstacle;
})();
