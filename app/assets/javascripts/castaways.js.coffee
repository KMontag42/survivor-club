$('#castaways').ready ->
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
          url: '/castaways.json'
          data: filter
    fields: [
      { name: 'name', type: 'text', title: 'Castaway' }
      { name: 'original_tribe', title: 'Original Tribe' }
      { name: 'swapped_tribe', title: 'Swapped Tribe' }
      { name: 'merged_tribe', title: 'Merged Tribe' }
      { name: 'voted_out_number', type: 'text', title: 'Voted Out' }
      { name: 'voted_out_episode', type: 'text', title: 'V.O. Episode' }
      { name: 'finish', type: 'text', title: 'Finish' }
      { name: 'tribal_votes', type: 'text', title: 'Tribal Votes' }
      { name: 'total_votes', type: 'text', title: 'Total Votes' }
      { name: 'season', title: 'Season' }
    ]

  $('#spoilers').on 'change', (e) ->
    target = $(e.target)
    if target.is(':checked')
      swal 'show spoilers'