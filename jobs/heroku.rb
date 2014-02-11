require 'heroku-api'

key = ENV['HEROKU_API_KEY']
app_name = ENV['HEROKU_APP_NAME']

heroku = Heroku::API.new(:api_key => key)

SCHEDULER.every '15s', :first_in => 0 do |job|
  ps = heroku.get_ps(app_name)
  dynos = ps.body.map { |p| p['process'] }
  process_counts = dynos.reduce({}) do |hash, dyno|
    process, i = dyno.split(".")
    hash[process] ||= 0
    hash[process] += 1
    hash
  end

  process_counts.each do |ps, n|
    send_event("heroku_dyno_#{ps}", { value: n })
  end
end
