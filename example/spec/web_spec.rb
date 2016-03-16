require 'spec_helper'

describe server(:web) do
  describe http('http://web') do
    it "responds content including 'Welcome to nginx!'" do
      expect(response.body).to include('Welcome to nginx!')
    end
    it "responds as 'text/html'" do
      expect(response.headers['content-type']).to eq("text/html")
    end
  end
end
