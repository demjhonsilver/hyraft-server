<div align="center">

# Hyraft Server

[![Gem Version](https://badge.fury.io/rb/hyraft-server.svg?icon=si%3Arubygems&icon_color=%23ffffff)](https://badge.fury.io/rb/hyraft-server)
![Downloads](https://img.shields.io/gem/dt/hyraft-server)
![License](https://img.shields.io/github/license/demjhonsilver/hyraft-server)
![Ruby Version](https://img.shields.io/badge/ruby-%3E%3D%203.4.0-red)


</div>



Web server for Hyraft framework

Dual-server web stack implementing hexagonal architecture. Supports simultaneous web and API servers across multiple Ruby backends (Puma, Thin, Falcon, Iodine) for the Hyraft platform.

## Installation

Open Gemfile:
put:

```bash
gem 'hyraft-server'
```

Switch to Thin # Gemfile in your application (Windows / Linux)
```bash
  gem 'thin'
```

Switch to Puma # Gemfile in your application (Windows / Linux)
```bash
  gem 'puma'
```


Switch server to Falcon # Gemfile in your application (Linux)
```bash
  gem 'falcon'
```

Switch server to Iodine # Gemfile in your application (Linux)
```bash
  gem 'iodine'
```



Install the gem and add to the application's Gemfile by executing:

```bash
bundle install
```


## Usage

Command Variants
```rb
Hotkey:

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

Examples:

hyr s thin                              # Start web server with Thin
hyr s puma                              # Start web server with Puma
hyr s iodine                            # Start web server with Iodine
hyr s falcon                            # Start web server with  Falcon

hyr-serve thin                          # Start web server with Thin
hyraft-server thin                      # Start web server with Thin
hyraft-server thin --api                # Start API server with Thin
hyraft-server puma -p 1091              # Start web server on port 1091
hyraft-server falcon --http2            # Start with HTTP/2 (Falcon)


```

## Usage - Test

Test Environment
```rb

Hotkey:

APP_ENV=test hyr s [server-name]                        Start web server (test)
APP_ENV=test hyr s [server-name] --api                  Start API server directly (test)
APP_ENV=test hyr s-v                                    Show version (test)
APP_ENV=test hyr s-h                                    Show this help (test)

ex.

APP_ENV=test hyr s thin
APP_ENV=test hyr s puma
APP_ENV=test hyr s iodine
APP_ENV=test hyr s falcon



```

## Usage - Production

Production Environment
```rb

Hotkey:

APP_ENV=production hyr s [server-name]                        Start web server (production)
APP_ENV=production hyr s [server-name] --api                  Start API server directly (production)
APP_ENV=production hyr s-v                                    Show version (production)
APP_ENV=production hyr s-h                                    Show this help (production)

ex.

APP_ENV=production hyr s thin
APP_ENV=production hyr s puma
APP_ENV=production hyr s iodine
APP_ENV=production hyr s falcon

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
