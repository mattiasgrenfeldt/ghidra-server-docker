# Ghidra server docker setup

Use like this:

```sh
mkdir ghidra-repos
# ghidra-repos should be owned by 1000:1000
# Replace <DOMAIN-OR-IP-HERE> in Dockerfile with the external IP or domain
# used to connect. This is used by TLS.
sudo docker compose up --build
```

## Administration

```sh
sudo docker compose exec ghidra ./ghidra/server/svrAdmin
sudo docker compose exec ghidra ./ghidra/server/svrAdmin -add <username> --p
```

Repositories are created by users when they connect, this is not done using
`svrAdmin`.
