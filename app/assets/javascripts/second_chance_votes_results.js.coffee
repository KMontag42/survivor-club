$("#second-change-votes-results").ready ->
  c3.generate({
    bindTo: '#chart',
    data: {
      url: '/second_chance_votes/get_data.json',
      mimeType: 'json',
      type: 'pie'
    },
    size: {
      height: 720
    },
    pie: {
      label: {
        format: (value, ratio, id) ->
          value
      }
    }
  })