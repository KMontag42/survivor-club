$('#episodes').ready ->
  $('#jsGrid').jsGrid
    height: '100%'
    width: '100%'
    filtering: true
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
      {
        name: 'name'
        type: 'text'
        title: 'Episode Name'
      }
      {
        name: 'won_reward'
        type: 'select'
        title: 'Won Reward'
        items: [
          'Kyle'
          'Hony'
          'Larry'
          'Brian'
        ]
      }
      {
        name: 'won_immunity'
        type: 'select'
        title: 'Won Immunity'
        items: [
          'Kyle'
          'Hony'
          'Larry'
          'Brian'
        ]
      }
      {
        name: 'voted_out'
        type: 'select'
        title: 'Voted Out'
        items: [
          'Kyle'
          'Hony'
          'Larry'
          'Brian'
          'Robby'
        ]
      }
      {
        name: 'season'
        type: 'select'
        title: 'Season'
        items: [
          '1'
          '2'
          '3'
          '4'
          '5'
        ]
      }
      {
        name: 'notes'
        type: 'text'
        title: 'Special Notes'
        filtering: false
      }
    ]

  $('#spoilers').on 'change', (e) ->
    target = $(e.target)
    if target.is(':checked')
      swal 'show spoilers'
