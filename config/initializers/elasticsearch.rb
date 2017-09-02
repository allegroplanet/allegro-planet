Elasticsearch::Model.client = Elasticsearch::Client.new url: (Rails.env.production? ? ENV['BONSAI_URL'] : 'http://localhost:9200')
