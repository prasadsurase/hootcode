class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registerable, :recoverable, :rememberable
  devise :database_authenticatable, :trackable, :validatable, :omniauthable, omniauth_providers: [:github]

  after_create :create_lifecycle_event

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def source_type
    provider.upcase if provider
  end

  def github_id
    uid.to_i if uid
  end

  private

  def create_lifecycle_event
    LifecycleEvent.create!(user: self, key: "joined")
  end
end
