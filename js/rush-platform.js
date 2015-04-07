window.Platform = (function() {
  var Platform, p;
  Platform = function(width) {
    this.initialize(width);
  };
  p = Platform.prototype = new window.GameObject;
  p.category = 'platform';
  p.GameObject_initialize = p.initialize;
  p.initialize = function(width) {
    var pImg, pLeft, pMiddle, pRight;
    this.width = width || 120;
    this.height = 12;
    if (width === 120) {
      pImg = new createjs.Bitmap('images/platform.png');
      return this.addChild(pImg);
    } else {
      pLeft = new createjs.Bitmap('images/platform-left.png');
      pRight = new createjs.Bitmap('images/platform-right.png');
      pMiddle = new createjs.Bitmap('images/platform-middle.png');
      pMiddle.x = 57;
      pMiddle.scaleX = width - 57 - 62;
      pRight.x = pMiddle.scaleX + pMiddle.x;
      this.addChild(pLeft);
      this.addChild(pMiddle);
      this.addChild(pRight);
    }
  };
  return Platform;
})();
