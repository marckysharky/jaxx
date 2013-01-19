# Jaxx

TODO: Write a gem description

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
    -h, --help
```

## Examples

### Upload from local machine
```
  jaxx-upload -b test-bucket -f vapour.txt -k MY_KEY -s MY_SECRET
```

### Download to local machine
```
  jaxx-download -b test-bucket -f vapour.txt -k MY_KEY -s MY_SECRET
```

### Upload to S3
```
  jaxx-upload -b test-bucket -f vapour.txt
```

### Download from S3 to current folder
```
  jaxx-download -b test-bucket -f vapour.txt
```

### Upload from local machine, and make it publicly available
```
  jaxx-upload -b test-bucket -f vapour.txt -k MY_KEY -s MY_SECRET -p public
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
