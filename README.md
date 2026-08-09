# Ferdium Server for YunoHost

YunoHost package for [Ferdium Server](https://github.com/ferdium/ferdium-server).

> **Status: experimental / not yet validated on a YunoHost test instance.**

This package installs Ferdium Server natively (without Docker), behind YunoHost's NGINX, using the default SQLite database.

## Packaged version

- Ferdium Server: `2.0.13`
- Node.js: `22.18.0`
- pnpm: `10.14.0`
- Database: SQLite
- Ferdium recipes submodule pinned to upstream commit `a0ea0575850c851fb3f6cb620102850bda999bee`

## Install

```bash
sudo yunohost app install https://github.com/xdespujols/ferdium_ynh
```

Use a dedicated domain/subdomain such as `ferdium.example.org`.

## Architecture

```text
Internet
  -> YunoHost NGINX / TLS
  -> 127.0.0.1:<allocated port>
  -> Ferdium Server systemd service
  -> SQLite in YunoHost data_dir
```

## Supported YunoHost operations

- install
- remove
- upgrade
- backup
- restore
- change URL
- multi-instance resource declaration

## Important

The package intentionally pins upstream source and recipes versions for reproducibility. Upgrades should update both pins after validation.

Before production use, run YunoHost package checks and an install/upgrade/backup/restore cycle on a disposable YunoHost instance.

## Upstream

- https://github.com/ferdium/ferdium-server
- https://github.com/ferdium/ferdium-recipes

## License

Ferdium Server is distributed under the MIT license. This packaging repository only contains YunoHost integration code.
