class Cora::Element
  include ActionView::Helpers::TagHelper
  attr_accessor :key

  def initialize key
    self.key = key
    @store = Redis::HashKey.new key
  end

  def id
    key
  end

  def read context
    @url = context.cora_engine.element_url(key)
    if authorized? context
      editable_content
    else
      public_content
    end
  end

  def content= value
    @store['content'] = value
  end

  def content
    @store['content']
  end

  def owner_id
    @store['owner_id']
  end

  def owner_id= value
    @store['owner_id'] = value
  end

  private

  def authorized? context
    context.instance_exec self, &janitor
  end

  def public_content
    content.blank? ? default_content : content
  end

  def editable_content
    content_tag Cora.editable_tag, public_content, role: 'cora-content', data: { 'cora-key' =>  key, 'cora-url' => url, 'cora-method' => :put }, class: 'cora-content'
  end

  def default_content
    'some content'
  end

  def janitor
    #Cora.janitor
    -> (element) do
      logged_in? and (current_user.id == element.owner_id.to_i or (element.owner_id.blank? and current_user.is_admin?))
    end
  end

  def url
    @url
  end
end
