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
      { name: 'original_tribe', type: 'select', title: 'Original Tribe', items: [ 'Kyle', 'Hony', 'Larry', 'Brian' ] }
      { name: 'swapped_tribe', type: 'select', title: 'Swapped Tribe', items: [ 'Kyle', 'Hony', 'Larry', 'Brian' ] }
      { name: 'merged_tribe', type: 'select', title: 'Merged Tribe', items: [ 'Kyle', 'Hony', 'Larry', 'Brian', 'Robby' ] }
      { name: 'voted_out_number', type: 'text', title: 'Voted Out' }
      { name: 'finish', type: 'text', title: 'Finish' }
      { name: 'tribal_votes', type: 'text', title: 'Tribal Votes' }
      { name: 'total_votes', type: 'text', title: 'Total Votes' }
      { name: 'voted_out_episode', type: 'text', title: 'Episode Name' }
      { name: 'season', type: 'select', title: 'Season', items: [ '1', '2', '3', '4', '5' ] }
    ]

  $('#spoilers').on 'change', (e) ->
    target = $(e.target)
    if target.is(':checked')
      swal 'show spoilers'