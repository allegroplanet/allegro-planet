RailsAdmin.config do |config|
  config.actions do
    dashboard
    index
    new
    show
    edit
    delete
    show_in_app
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
        :slug,
        :website,
        :description
    end

    show do
      exclude_fields :password_digest
    end

    edit do
      exclude_fields :created_at,
        :password_digest
      configure :slug do
        read_only true
      end
    end
  end

  # Game

  config.model 'Game' do
    edit do
      exclude_fields :created_at,
        :updated_at
      configure :slug do
        read_only true
      end
    end
  end
end
