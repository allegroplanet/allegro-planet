RailsAdmin.config do |config|
  config.authorize_with do
    authenticate_or_request_with_http_basic('Login Required') do |username, password|
      if Rails.env.production?
        username == Rails.application.secrets.admin_login_username && password == Rails.application.secrets.admin_login_password
      else
        true
      end
    end
  end

  config.actions do
    dashboard
    index
    new
    show
    edit
    delete
    show_in_app
  end

  # Article

  config.model 'Article' do
    object_label_method do
      :title
    end

    edit do
      field :title
      field :handle do
        read_only true
        help "Auto-generated based on title."
      end
      field :body_markdown
    end
  end

  # User

  config.model 'User' do
    object_label_method do
      :username
    end

    list do
      exclude_fields :created_at,
        :email,
        :updated_at,
        :password_digest,
        :handle,
        :website,
        :description
    end

    show do
      exclude_fields :password_digest
    end

    edit do
      exclude_fields :created_at,
        :password_digest
      configure :handle do
        read_only true
      end
    end
  end

  # Game

  config.model 'Game' do
    edit do
      exclude_fields :created_at,
        :updated_at
      configure :handle do
        read_only true
        help 'Generated automatically.'
        visible { bindings[:object].id.present? }
      end
    end
  end

  # GameRelease

  config.model 'GameRelease' do
    object_label_method do
      :game_release_label_method
    end
  end

  # GameFile

  config.model 'GameFile' do
    configure :category, :enum do
      enum do
        GameFile::GAME_FILE_CATEGORIES.each.collect { |element| [element] }
      end
    end
  end

  def game_release_label_method
    "#{self.game.handle}-#{self.version_num}"
  end
end
