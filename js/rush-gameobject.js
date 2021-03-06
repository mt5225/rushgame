window.GameObject = (function() {
  var GameObject, p;
  GameObject = function() {
    this.initialize();
  };
  p = GameObject.prototype = new createjs.Container();
  p.Container_initialize = p.initialize;
  p.initialize = function() {
    this.Container_initialize();
    this.category = 'object';
    this.width = 0;
    this.height = 0;
  };
  p.hit = function(point) {
    if (point.x >= 0 && point.x <= this.width && point.y >= 0 && point.y <= this.height) {
      return true;
    } else {
      return false;
    }
  };
  return GameObject;
})();
