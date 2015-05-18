$(document).ready ->
  group_id = '371816539634597'
  graph_url = "https://graph.facebook.com/#{group_id}/feed"
  data = $.get(graph_url)
  console.log data