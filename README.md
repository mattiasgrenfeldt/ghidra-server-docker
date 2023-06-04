# Ghidra server docker setup

Use like this:

```sh
mkdir ghidra-repos
# ghidra-repos should be owned by 1000:1000
sudo docker compose up --build
```

## Administration

```sh
sudo docker compose exec ghidra ./ghidra/server/svrAdmin -add <username> --p
```
