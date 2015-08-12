Registry[:google_api_connection] =
  HTTPConnectionFactory.build('https://www.googleapis.com/')

Registry[:search_repository] =
  Search::GoogleCustomSearchEngine.new(ENV['GOOGLE_API_KEY'], ENV['GOOGLE_API_CX'])
