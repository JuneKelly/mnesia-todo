# Mnesia-Todo

A simple demo of Elixir and Mnesia, implementing a todo-list.


## Running

```shell
$ iex -S mix
```


## Example

```elixir
key = Todo.add("wash the dishes")
# = >"L33DAXT3KLW7BBT6"

Todo.show(key)

Todo.done(key)

Todo.archive(key)

Todo.list()

Todo.list(all: true)
```
