WebsocketRails::EventMap.describe do
  # You can use this file to map incoming events to controller actions.
  # One event can be mapped to any number of controller actions. The
  # actions will be executed in the order they were subscribed.
  #
  # Uncomment and edit the next line to handle the client connected event:
  #   subscribe :client_connected, :to => Controller, :with_method => :method_name
  #
  # Here is an example of mapping namespaced events:
  #   namespace :product do
  #     subscribe :new, :to => ProductController, :with_method => :new_product
  #   end
  # The above will handle an event triggered on the client like `product.new`.

  subscribe :send_chat, to: ChatController, with_method: :send_chat
  subscribe :user_joined, to: ChatController, with_method: :user_joined
  subscribe :user_left, to: ChatController, with_method: :user_left

  subscribe :player_clicked, to: LiveController,
                             with_method: :player_clicked

  subscribe :contestant_clicked, to: LiveController,
                                 with_method: :contestant_clicked

  namespace :drafts do
    subscribe :next_player, to: DraftEventsController, with_method: :next_player
    subscribe :join_draft, to: DraftEventsController, with_method: :join_draft
    subscribe :pick_contestant,
              to: DraftEventsController,
              with_method: :pick_contestant
    subscribe :start_draft, to: DraftEventsController, with_method: :start_draft
    subscribe :ready_to_start,
              to: DraftsController,
              with_method: :ready_to_start
  end
end
