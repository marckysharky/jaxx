# Jaxx

Upload and Download files from S3.

## Installation

Add this line to your application's Gemfile:

    gem 'jaxx'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jaxx

## Usage

### Upload
```
  jaxx-upload -h
  jaxx [options]
    -b, --bucket [BUCKET]
    -k, --access-key [ACCESS_KEY]
    -s [ACCESS_SECRET],
    --access-secret
    -f, --file [FILE]
    -p, --privacy [PRIVACY]
    -r, --retries [retries]
    -h, --help
```

### Download
```
  jaxx-download -h
  jaxx [options]
    -b, --bucket [BUCKET]
    -k, --access-key [ACCESS_KEY]
    -s [ACCESS_SECRET],
    --access-secret
    -f, --file [FILE]
    -p, --privacy [PRIVACY]
    -r, --retries [retries]
    -h, --help
```

### About Me
```
  jaxx-aboutme -h
  jaxx-aboutme [options]
    -d, --display
    -h, --help
```

## Examples

### Upload file from local machine
```
  jaxx-upload -b test-bucket -f vapour.txt -k MY_KEY -s MY_SECRET
```

### Upload directory from local machine
```
  jaxx-upload -b test-bucket -f dir/ -k MY_KEY -s MY_SECRET
```

### Download file to local machine
```
  jaxx-download -b test-bucket -f vapour.txt -k MY_KEY -s MY_SECRET
```

### Upload file to S3 from AWS Instance
```
  jaxx-upload -b test-bucket -f vapour.txt
```

### Download file from S3 to current folder from AWS Instance
```
  jaxx-download -b test-bucket -f vapour.txt
```

### Upload file from local machine, and make it publicly available
```
  jaxx-upload -b test-bucket -f vapour.txt -k MY_KEY -s MY_SECRET -p public
```

### Upload directory from local machine, and make it publicly available
```
  jaxx-upload -b test-bucket -f dir/ -k MY_KEY -s MY_SECRET -p public
```

### Download file from S3 to current folder from AWS Instance, and retry 5 times on failure
```
  jaxx-download -b test-bucket -f vapour.txt -r 5
```

### Get information on the instance you are currently on
```
  jaxx-aboutme -d
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
