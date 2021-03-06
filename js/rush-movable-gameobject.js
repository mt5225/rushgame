window.MovableGameObject = (function() {
  var MovableGameObject, p;
  MovableGameObject = function() {
    return this.initialize();
  };
  p = MovableGameObject.prototype = new window.GameObject();
  p.GameObject_initialize = p.initialize;
  p.initialize = function() {
    this.GameObject_initialize();
    this.velocity = new createjs.Point(0, 0);
    this.dropSpeed = 1;
    this.onGroud = false;
    createjs.Ticker.setFPS(40);
    createjs.Ticker.addEventListener("tick", (function(evt) {
      if (!evt.paused && !this.onGroud) {
        this.velocity.y += this.dropSpeed;
        return this.velocity.y = Math.min(this.velocity.y, 5);
      }
    }).bind(this));
  };
  return MovableGameObject;
})();
