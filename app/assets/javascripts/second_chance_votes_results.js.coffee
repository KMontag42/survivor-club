$("#second-change-votes-results").ready ->
  c3.generate({
    bindto: '#chart1',
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
  c3.generate({
    bindto: '#chart2',
    data: {
      url: '/second_chance_votes/get_data.json',
      mimeType: 'json',
      type: 'bar'
    },
    size: {
      height: 720
    },
    bar: {
      width: {
        ratio: 0.5 # this makes bar width 50% of length between ticks
      }
    # or
    #width: 100 # this makes bar width 100px
    }
  })