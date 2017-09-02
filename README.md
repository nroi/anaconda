# Anaconda

## Configuration
Take a look at `config/config.exs`.

## Running

1. via IEx:
  Just run ```iex -S mix```

or

2. via systemd:
  first, create a release:
  ```shell
  mix release.init
  MIX_ENV=prod mix release --env=prod
  ```
  
  Then, use the included systemd file which runs the command `_build/prod/rel/anaconda/bin/anaconda foreground`.
  If you choose to start anaconda with systemd, you will need to update the path
  mentioned in `ExecStart`. Also note that the systemd service file is meant to be used as a systemd
  user service.

## Usage

```shell
curl -X POST -H "shorten-url: https://github.com" localhost:4072/
```
will shorten the URL `https://github.com`.
