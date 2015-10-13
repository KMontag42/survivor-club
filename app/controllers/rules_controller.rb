class RulesController < ApplicationController
  def index
    @rules = RuleArticle.all
  end
end
