class RulesController < ApplicationController
  def index
    @rules = {
        preamble: '',
        sr1_duties_and_powers: '',
        sr2_definitions: ''
    }
  end
end
