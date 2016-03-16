# Infrataster Docker Image
Docker Image for [Infrataster](https://github.com/ryotarai/infrataster).

## SUPPORTED TAGS

* `latest`
 * Ruby 2.3.0
 * Infrataster v0.3.2

## HOW TO USE
Run your container to test.

```bash
$ docker run -d --name web -p 80 nginx
```

Prepare spec files.

```
$ rspec --init
  create   spec/spec_helper.rb
  create   .rspec
```

Configure `spec_helper`.

```ruby
# spec/spec_helper.rb
require 'infrataster/rspec'

Infrataster::Server.define(:web) do |server|
  server.address = '127.0.0.1'
end
```

Write a test.

```ruby
# spec/web_spec.rb
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
```

Get the infrataster image.

```bash
$ docker pull quay.io/spesnova/infrataster:latest
```

Run the test.

```
$ docker run \
    -v $PWD/spec:/test/spec \
    --net='container:web' \
    quay.io/spesnova/infrataster:latest

..

Finished in 0.0162 seconds (files took 0.87936 seconds to load)
2 examples, 0 failures
```

See an example using Docker Compose.
