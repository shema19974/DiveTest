require 'client-api'
# Testing using data from real Api
api = ClientApi::Api.new
describe "Testing my Api's" do

    it "Providing the true url" do
    api.get('/programLanguages')
    expect(api.status).to eq(200) 
    end

    it "Providing the wrong api" do
        api.get('/programLanguages1')
        expect(api.status).to eq(404) 
    end

    it "Return the size of returned responses" do
        api.get('/programLanguages')
        validate(
            api.body,
            {
                "key": "",
                "size": 5
            }
        )
    end
end

# Testing using mock data 
class FetchLanguage 
    def initialize(languages) 
       @languages = languages
    end 
    
    def fetch()
        @languages.map { |s| "{#{s.code},#{s.displayName}}"}.join(',')
    end 
 end
describe FetchLanguage do 
    it 'The list_languages_names method should work correctly' do 
        lang1 = class_double('language','displayName') 
        lang2 = class_double('language','displayName') 
        lang3 = class_double('language','displayName')
        
        allow(lang1).to receive(:code) { 'ruby'} 
        allow(lang1).to receive(:displayName) {'Ruby'}

        allow(lang2).to receive(:code) { 'python'} 
        allow(lang2).to receive(:displayName) { 'Python'} 

        allow(lang3).to receive(:code) { 'java'} 
        allow(lang3).to receive(:displayName) { 'Java'} 
        
        cr = FetchLanguage.new [lang1,lang2, lang3]
        responses = cr.fetch
        expect(responses).to eq('{ruby,Ruby},{python,Python},{java,Java}') 
    end 
end

