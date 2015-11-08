$('#castaways').ready ->
  $('#jsGrid').jsGrid
    height: '400px'
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
          url: '/castaways.json'
          data: filter
    fields: [
      { name: 'name', type: 'text', title: 'Castaway' }
      { name: 'original_tribe', title: 'Original Tribe', filtering: false }
      { name: 'swapped_tribe', title: 'Swapped Tribe', filtering: false }
      { name: 'merged_tribe', title: 'Merged Tribe', filtering: false }
      { name: 'voted_out_number', type: 'text', title: 'Voted Out', filtering: false }
      { name: 'voted_out_episode', type: 'text', title: 'V.O. Episode', filtering: false }
      { name: 'finish', type: 'text', title: 'Finish', filtering: false }
      { name: 'tribal_votes', type: 'text', title: 'Tribal Votes', filtering: false }
      { name: 'total_votes', type: 'text', title: 'Total Votes', filtering: false }
      { name: 'season', title: 'Season' }
    ]

  $('#spoilers').on 'change', (e) ->
    target = $(e.target)
    if target.is(':checked')
      swal 'show spoilers'