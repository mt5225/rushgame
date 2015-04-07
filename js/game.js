window.onload = function() {
  var game, restartBtn, startBtn;
  game = new window.Game();
  startBtn = document.getElementById("start-btn");
  startBtn.onclick = function() {
    var menuScene;
    menuScene = document.getElementById("menu");
    menuScene.classList.add('hidden');
    return game.initGame();
  };
  restartBtn = document.getElementById("restart-btn");
  restartBtn.onclick = function() {
    var menuScene;
    menuScene = document.getElementById("gameover");
    menuScene.classList.add('hidden');
    return game.initGame();
  };
};
