class User < ActiveRecord::Base
  serialize :auth_hash

  after_create :create_cora_element

  def to_s
    name
  end

  def is_admin?
    nickname == 'pismenny'
  end

  def url
    twitter_url || github_url
  end

  #def avatar_url
    #url = read_attribute('avatar_url')
    #url.blank? ? url : 'http://placehold.it/64x64'
  #end

  def self.create_with_omniauth(auth)
    user = create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.avatar_url = auth["info"]["image"]
      user.nickname = auth['info']['nickname']
      user.auth_hash = auth
    end
  end

  private

  def github_url
    auth_hash['info']['urls']['Twitter']
  rescue
    nil
  end

  def twitter_url
    auth_hash['info']['urls']['GitHub']
  rescue
    nil
  end

  def create_cora_element
    e = Cora::Element.new "user:#{id}"
    e.content = description
    e.owner_id = id
  end

  def description
    auth_hash['info']['description'] || auth_hash['extra']['raw_info']['bio'] || auth_hash['info']['name']
  end
end
