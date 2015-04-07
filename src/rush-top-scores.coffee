#######
# top scores class
#######
window.TopScores = do ->
  TopScores = ->
    if localStorage['scores']
      @data = JSON.parse(localStorage['scores'])
    else
      @data = scores: []
    return

  p = TopScores.prototype

  p.saveScore = (score) ->
    @data.scores.push score
    @data.scores.sort (a, b) ->
      b - a
    @data.scores = @data.scores.slice 0,3
    localStorage['scores'] = JSON.stringify @data

  p.toHtml = ->
    html = '<ul>'
    rank = 1
    for score in @data.scores
      html += "<li> rank #{rank}: #{score} </li>"
      rank++
    html += '</ul>'
    html

  TopScores
