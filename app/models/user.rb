class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, :token_authenticatable
  has_one :profile
  after_create :create_profile
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email,:username, :password, :password_confirmation, :remember_me

  #mailboxer gem
  acts_as_messageable

  def name
    email
  end

  def mailboxer_email(object)
    email
  end

  def self.build(opts = {})
      u = User.new(opts)
      u.setup(opts)
      u
    end

  def setup(opts)

    self.email = opts[:email]

    self.valid?
    errors = self.errors

  end

  def create_profile
    profile = Profile.new
    profile.user_id = self.id
    profile.save
  end
end
