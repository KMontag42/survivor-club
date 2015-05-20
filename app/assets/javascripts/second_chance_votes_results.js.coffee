$("#second-change-votes-results").ready ->
  c3.generate({
    bindTo: '#chart',
    data: {
      url: '/second_chance_votes/get_data.json',
      mimeType: 'json',
      type: 'pie'
    },
    pie: {
      label: {
        format: (value, ratio, id) ->
          value
      }
    }
  })