<div align="center">

# Hyraft Server

[![Gem Version](https://badge.fury.io/rb/hyraft-server.svg?icon=si%3Arubygems&icon_color=%23ffffff)](https://badge.fury.io/rb/hyraft-server)
![Downloads](https://img.shields.io/gem/dt/hyraft-server)
![License](https://img.shields.io/github/license/demjhonsilver/hyraft-server)
![Ruby Version](https://img.shields.io/badge/ruby-%3E%3D%204.0.0-blue)
![Tests](https://github.com/demjhonsilver/hyraft-server/actions/workflows/ci.yml/badge.svg)



</div>



Server for Hyraft framework

____________________

Dual-server web stack implementing hexagonal architecture. Supports simultaneous web and API servers across multiple Ruby backends (Puma, Thin, Falcon, Iodine) for the Hyraft framework.


## Installation

```bash
Server options:
___________________________________________________

Use Thin server:      gem 'thin'    # Windows/Linux
Use Puma server:      gem 'puma'    # Windows/Linux
Use Falcon server:    gem 'falcon'  # Linux
Use Iodine server:    gem 'iodine'  # Linux

```


## Usage

Command Variants
```rb
_______________________________________________________________________

Alias: (or Shortcut)

hyr s [server-name]                        Start web server
hyr s [server-name] --api                  Start API server directly
hyr s-v                                    Show version
hyr s-h                                    Show this help
_______________________________________________________________________

Medium Form:

hyr-serve [server-name]                    Start web server
hyr-serve [server-name] --api              Start API server directly
hyr-serve s-v                              Show version
hyr-serve s-h                              Show this help
_______________________________________________________________________

Full Command:

hyraft-server [server-name] [options]      Start web server
hyraft-server [server-name] --api [options] Start API server directly
hyraft-server server-version               Show version
hyraft-server server-help                  Show this help

_______________________________________________________________________

Examples:

hyr s thin                              # Start web server with Thin
hyr s puma                              # Start web server with Puma
hyr s iodine                            # Start web server with Iodine
hyr s falcon                            # Start web server with  Falcon

hyr-serve thin                          # Start web server with Thin
hyraft-server thin                      # Start web server with Thin
hyraft-server thin --api                # Start API server with Thin
hyraft-server puma -p 1025              # Start web server on port 1025
hyraft-server puma --port-api 1126      # Start API server on port 1126
hyraft-server falcon --http2            # Start with HTTP/2 (Falcon)
hyraft-server falcon --http3            # Start with HTTP/3 (Falcon)
_______________________________________________________________________


```

## Usage - Test

Test Environment
```rb

Alias: (or Shortcut)

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

Alias: (or Shortcut)

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
