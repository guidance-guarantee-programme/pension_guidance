# Pension Guidance

[![Build Status](https://travis-ci.org/guidance-guarantee-programme/pension_guidance.svg)](https://travis-ci.org/guidance-guarantee-programme/pension_guidance)

Pension Guidance delivered by the Guidance Guarantee Programme.


## Prerequisites

* [Bundler]
* [Git]
* [Node.js][Node]
* [NPM]
* [Ruby 2.1.5][Ruby]


## Installation

Clone the repository:

```sh
$ git clone https://github.com/guidance-guarantee-programme/pension-guidance.git
```

Make sure all Ruby dependencies are available to the application:

```sh
$ bundle install
```

Make sure all Node.js dependencies are available to the application:

```sh
$ npm install
```

## Usage

To start the application:

```sh
$ ./bin/foreman s
```

## Heroku

To run this application on [Heroku], enable [multiple buildpack] support:

```sh
$ heroku config:set BUILDPACK_URL=https://github.com/ddollar/heroku-buildpack-multi.git
```

## Contributing

Please see the [contributing guidelines](/CONTRIBUTING.md).

[bundler]: http://bundler.io
[git]: http://git-scm.com
[heroku]: https://www.heroku.com
[multiple buildpack]: https://github.com/ddollar/heroku-buildpack-multi
[node]: http://nodejs.org
[npm]: https://www.npmjs.org
[ruby]: http://www.ruby-lang.org/en
