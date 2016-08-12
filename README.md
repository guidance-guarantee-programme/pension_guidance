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
* [Ruby 2.3.1][Ruby]


## Installation

Clone the repository:

```sh
$ git clone https://github.com/guidance-guarantee-programme/pension_guidance.git
```

Install PrinceXML:

```sh
$ http://www.princexml.com/download/
```

Install and start Redis:

```sh
$ brew install redis && brew services start redis
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

## Wraith

In order to check visual differences between development and live use wraith

```sh
$ npm run wraith
```

A browser window should open up showing the results when complete

N.B. Wraith requires PhantomJS (2.1.1) and ImageMagick in order to run

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
