class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable,
         :confirmable

  as_enum :role, [:guest, :regular, :trusted, :moderator, :admin],
          source: :role, map: :string, accessor: :whiny

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
