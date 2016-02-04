class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registerable, :recoverable, :rememberable
  devise :database_authenticatable, :trackable, :validatable, :omniauthable, omniauth_providers: [:github]

  has_many :submissions
  has_many :alerts
  has_many :notifications
  has_many :comments
  has_many :exercises, class_name: "UserExercise"
  has_many :lifecycle_events, ->{ order 'created_at ASC' }, class_name: "LifecycleEvent"

  has_many :management_contracts, class_name: "TeamManager"
  has_many :managed_teams, through: :management_contracts, source: :team
  has_many :team_memberships, ->{ where confirmed: true }, class_name: "TeamMembership"
  has_many :teams, through: :team_memberships
  has_many :unconfirmed_team_memberships, ->{ where confirmed: false }, class_name: "TeamMembership"
  has_many :unconfirmed_teams, through: :unconfirmed_team_memberships, source: :team



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
