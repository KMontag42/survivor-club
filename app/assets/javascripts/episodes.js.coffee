$('#episodes').ready ->
  $('#jsGrid').jsGrid
    height: '400px'
    width: '100%'
    sorting: true
    paging: true
    autoload: true
    pageSize: 10
    pageButtonCount: 5
    controller:
      loadData: (filter) ->
        $.ajax
          type: 'GET'
          url: '/episodes.json'
          data: filter
    fields: [
      { name: 'name', type: 'text', title: 'Episode Name' }
      { name: 'won_reward', title: 'Won Reward' }
      { name: 'won_immunity', title: 'Won Immunity' }
      { name: 'voted_out', title: 'Voted Out' }
      { name: 'season', title: 'Season' }
      { name: 'notes', type: 'text', title: 'Special Notes' }
    ]

  $('#spoilers').on 'change', (e) ->
    target = $(e.target)
    if target.is(':checked')
      swal 'show spoilers'
