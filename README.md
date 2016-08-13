# Kihu::Parser

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/kihu/parser`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kihu-parser'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kihu-parser

## Usage

Kihu::Parser.parse(text)

Argument is orginary kihu format like below. 

1 ２六歩(27)   ( 0:03/00:00:03)
2 ３四歩(33)   ( 0:02/00:00:02)
3 ２五歩(26)   ( 0:02/00:00:05)

Then convert array of object that is easy to handle on programs.

[
  {
    koma: 'Hu',
    from: {x: 2, y: 7},
    to: {x: 2, y: 6},
    naru: false,
    utsu: false,
    time: 1
  },
  {
    koma: 'Hu',
    from: {x: 2, y: 7},
    to: {x: 2, y: 6},
    naru: false,
    utsu: false,
    time: 12
  },
  {
    koma: 'Hu',
    from: {x: 2, y: 7},
    to: {x: 2, y: 6},
    naru: false,
    utsu: false,
    time: 24
  }
]

# Parametors

- koma
  koma type: string
  Hu, Kin, Gin, Ou, Keima, Kyousya, Hisya, Kaku

- from
  before moved position hash

- to 
  after moved position hash

- naru
  boolean

- utsu
  whether utsu

- time
  accumulated seconds from start



## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

