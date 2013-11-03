require "cora/engine"

module Cora

  extend ActiveSupport::Autoload
  autoload :Backends
  autoload :Authorizer

  mattr_accessor :editable_tag
  @@editable_tag = :span

  mattr_accessor :namespace
  @@namespace = :cora

  mattr_accessor :backend
  @@backend = Cora::Backends::Redis.new

  mattr_accessor :authorizer
  @@authorizer = Cora::Authorizer.new

  mattr_accessor :janitor
  @@janitor = -> (element) { current_user.is_admin? }

  mattr_accessor :path
  @@path = '/cora'

end

require 'cora/controller'
require 'cora/element'
require 'cora/action_view_extensions'
#require 'cora/config'
