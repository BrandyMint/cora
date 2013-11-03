# -*- coding: utf-8 -*-
# configures your navigation
#
# ListBootstrap - https://gist.github.com/gmjorge/2572869


SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    if logged_in?

      primary.item :user, "@#{current_user.nickname}", current_user.url
      primary.item :logout, 'Выйти', logout_url
    else
      primary.item :login, 'Войти через twitter', '/auth/twitter'
      primary.item :login, 'Войти через github', '/auth/github'
      #primary.item :signup, 'Регистрация', '/signup'
      #primary.item :developer, 'developer', '/auth/developer' if Rails.env.development?
    end

    primary.dom_class = 'nav navbar-nav pull-right'

    # you can turn off auto highlighting for a specific level
    primary.auto_highlight = true
  end
end
