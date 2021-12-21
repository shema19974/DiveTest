require 'client-api'

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