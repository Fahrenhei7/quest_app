class SuggestionPolicy < ApplicationPolicy
  attr_reader :user, :suggestion

  def initialize(user, suggestion)
    @user = user
    @suggestion = suggestion
  end

  %w(edit? update? destroy?).each do |m|
    define_method(m) do
      suggestion.user == user
    end
  end
end
