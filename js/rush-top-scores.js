window.TopScores = (function() {
  var TopScores, p;
  TopScores = function() {
    if (localStorage['scores']) {
      this.data = JSON.parse(localStorage['scores']);
    } else {
      this.data = {
        scores: []
      };
    }
  };
  p = TopScores.prototype;
  p.saveScore = function(score) {
    this.data.scores.push(score);
    this.data.scores.sort(function(a, b) {
      return b - a;
    });
    this.data.scores = this.data.scores.slice(0, 3);
    return localStorage['scores'] = JSON.stringify(this.data);
  };
  p.toHtml = function() {
    var html, i, len, rank, ref, score;
    html = '<ul>';
    rank = 1;
    ref = this.data.scores;
    for (i = 0, len = ref.length; i < len; i++) {
      score = ref[i];
      html += "<li> rank " + rank + ": " + score + " </li>";
      rank++;
    }
    html += '</ul>';
    return html;
  };
  return TopScores;
})();
