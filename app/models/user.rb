# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role                   :string           default("guest"), not null
#  location_id            :integer
#

class User < ActiveRecord::Base
  as_enum :role, [:guest, :regular, :trusted, :moderator, :admin],
          source: :role, map: :string, accessor: :whiny

  belongs_to :location

  delegate :address, to: :location

  before_create do
    self.role = :regular
  end

  def self.guest
    User.new
  end

  def guest?
    new_record?
  end

  def regular?
    persisted? && role == :regular
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

end
