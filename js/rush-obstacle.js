// Generated by CoffeeScript 1.9.1
(function() {
  window.Obstacle = (function() {
    var Obstacle, p;
    Obstacle = function() {
      this.initialize();
    };
    p = Obstacle.prototype = new window.GameObject();
    p.category = 'obstacle';
    p.GameObject_initialize = p.initialize;
    p.initialize = function() {
      var shape;
      this.width = 40;
      this.height = 20;
      shape = window.CommonShapes.rectangle({
        width: this.width,
        height: this.height,
        fillColor: "#f00"
      });
      this.addChild(shape);
      this.regX = this.width / 2;
      this.regY = this.height;
    };
    return Obstacle;
  })();

}).call(this);