# Kihu::Parser

## Usage

Kihu::Parser.parse(text)

Argument is ordinary kihu format like below. 

```
1 ２六歩(27)   ( 0:03/00:00:03)
2 ３四歩(33)   ( 0:02/00:00:02)
3 ２五歩(26)   ( 0:02/00:00:05)
```

Then convert array of hash that is easy to handle on programs.
```ruby
{
  date: Time(2016/08/02 20:04:56),
  rule: 'R対局(15分)',
  handicap: '平手',
  sente: 'foo',
  gote: 'bar',
  moves: {
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
  }
}

```

# Moves parameters

- koma
  string: koma type.
  Hu, Kin, Gin, Ou, Keima, Kyousya, Hisya, Kaku etc.

- from
  hash: before moved position

- to 
  hash: after moved position

- naru
  boolean: whether naru

- utsu
  boolean: whether utsu

- time
  int: accumulated seconds from start



## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

