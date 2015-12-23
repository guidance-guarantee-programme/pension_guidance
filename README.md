# Pension Guidance

[![Build Status](https://travis-ci.org/guidance-guarantee-programme/pension_guidance.svg)](https://travis-ci.org/guidance-guarantee-programme/pension_guidance)

Pension guidance from [Pension Wise].


## Prerequisites

* [Bundler]
* [Git]
* [Node.js][Node]
* [NPM]
* [PhantomJS][phantomjs]
* [Redis]
* [Ruby 2.3.0][Ruby]


## Installation

Clone the repository:

```sh
$ git clone https://github.com/guidance-guarantee-programme/pension_guidance.git
```

Setup the application:

```sh
$ ./bin/setup
```

## Usage

To start the application:

```sh
$ ./bin/foreman s
```

## Image sprites

These are generated at the various sizes using [svgexport]. Update `svg/circles.svg` and run the following to
regenerate the PNG files.

```sh
$ npm run svgexport
```

## Heroku

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)


## Contributing

Please see the [contributing guidelines](/CONTRIBUTING.md).

[bundler]: http://bundler.io
[git]: http://git-scm.com
[heroku]: https://www.heroku.com
[node]: http://nodejs.org
[npm]: https://www.npmjs.org
[pension wise]: https://www.pensionwise.gov.uk
[phantomjs]: http://phantomjs.org
[redis]: http://redis.io/
[ruby]: http://www.ruby-lang.org/en
[svgexport]: https://github.com/shakiba/svgexport
