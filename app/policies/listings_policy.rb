class ListingsPolicy < ApplicationPolicy
  attr_reader :listing

  def initialize(user, listing)
    @user = user
    @listing = listing
  end

  def create?
    @user.admin?
  end

end
