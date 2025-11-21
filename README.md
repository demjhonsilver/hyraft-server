# Hyraft Server

Web server for Hyraft framework

Dual-server web stack implementing hexagonal architecture. Supports simultaneous web and API servers across multiple Ruby backends (Puma, Thin, Falcon, Iodine) for the Hyraft platform.

## Installation

Open Gemfile:
put:

```bash
gem 'hyraft-server'
```

Install the gem and add to the application's Gemfile by executing:

```bash
bundle install
```


## Usage

Command Variants
Hotkey:

```rb

hyr s [server-name]                        Start web server
hyr s [server-name] --api                  Start API server directly
hyr s-v                                    Show version
hyr s-h                                    Show this help
Shortkey:

hyr-serve [server-name]                    Start web server
hyr-serve [server-name] --api              Start API server directly
hyr-serve s-v                              Show version
hyr-serve s-h                              Show this help
Standard:

hyraft-server [server-name] [options]      Start web server
hyraft-server [server-name] --api [options] Start API server directly
hyraft-server server-version               Show version
hyraft-server server-help                  Show this help
Examples
hyr s thin                              # Start web server with Thin
hyr-serve thin                          # Start web server with Thin
hyraft-server thin                      # Start web server with Thin
hyraft-server thin --api                # Start API server with Thin
hyraft-server puma -p 1091              # Start web server on port 1091
hyraft-server falcon --http2            # Start with HTTP/2 (Falcon)


```
## Development

After checking out the repo, run `bundle install` to install dependencies.

Then, run `rake test` to run the tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/demjhonsilver/hyraft-server. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/demjhonsilver/hyraft-server/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Hyraft::Server project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/demjhonsilver/hyraft-server/blob/master/CODE_OF_CONDUCT.md).
