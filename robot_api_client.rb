require 'net/http'
require 'json'
require 'csv'

class FetchLanguage
    def fetch(url)
        # You should choose a better exception.
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(uri.request_uri)
        request.basic_auth(ARGV[1], ARGV[2])
        response = http.request(request)
        response_data = JSON.parse(response.body)
        if response.message == 'OK' 
            if(ARGV[0] == 'json')
                response_data.each do |data|
                    # puts data["code"] + " \t " + data["displayName"]
                    puts data.to_json
                end
            elsif (ARGV[0] == 'csv')
                puts 'code' + ',' +'displayName'
                response_data.each do |data|
                    # puts data["code"] + " \t " + data["displayName"]
                    puts [data['code'], data['displayName']].to_csv
                end
            end
        end
    end
end

response = FetchLanguage.new
response.fetch('https://robot.diveintocode.jp:17777/programLanguages')