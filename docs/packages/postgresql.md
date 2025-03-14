﻿# <img src="https://cdn.jsdelivr.net/gh/mkevenaar/chocolatey-packages@146ea9a4b2fdab35e5de69a738307afe89969e9b/icons/postgresql.png" width="32" height="32"/> [![PostgreSQL](https://img.shields.io/chocolatey/v/postgresql17.svg?label=PostgreSQL)](https://community.chocolatey.org/packages/postgresql17) [![PostgreSQL](https://img.shields.io/chocolatey/dt/postgresql17.svg)](https://community.chocolatey.org/packages/postgresql17)

## Usage

To install PostgreSQL, run the following command from the command line or from PowerShell:

```powershell
choco install postgresql17
```

To upgrade PostgreSQL, run the following command from the command line or from PowerShell:

```powershell
choco upgrade postgresql17
```

To uninstall PostgreSQL, run the following command from the command line or from PowerShell:

```powershell
choco uninstall postgresql17
```

## Description

PostgreSQL is an object-relational database management system (ORDBMS) based on POSTGRE, developed at the University of California at Berkeley Computer Science Department. POSTGRES pioneered many concepts that only became available in some commercial database systems much later.

PostgreSQL can be used, modified, and distributed by anyone free of charge for any purpose, be it private, commercial, or academic.

## Features

- [Feature Matrix](https://www.postgresql.org/about/featurematrix)

## Package parameters

- `/AllowRemote` - Allow remote connections with username and password from all hosts by adding appropriate lines in the `pg_hba.conf`
- `/Password` - Password to be assigned to the `postgres` user. If omitted, it will be generated and shown in the install output. PostgreSql installer ignores this parameter if there is existing installation.
- `/Port` - Server port, if not set it defaults to `5432` or the first available port after it.
- `/NoPath` - Do not add PostgreSql bin directory to the PATH.

Other parameters could be set via `--ia` argument, for example, to set custom components:

```sh
choco install postgresql13 --params '/Password:test /Port:5433' --ia '--enable-components server,commandlinetools'
```

Check all [installer](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads) options by adding `--help` as command line argument.

## Notes

- Test installation (specify your password):
`$Env:PGPASSWORD='test'; '\conninfo' | psql -Upostgres`
This should output:
`You are connected to database "postgres" as user "postgres" on host "localhost" at port "5432"`
- This package will install PostgreSQL to `$Env:ProgramFiles\PostgreSQL\[MajorVersion]`.
- If you have problems during installation see [troubleshooting page](https://wiki.postgresql.org/wiki/Troubleshooting_Installation).
- If you didn't specify password during setup and didn't record the generated one, you need manually reset it using the following steps:
    - Open file `data\pg_hba.conf` in PostgreSql installation directory
    - Change `METHOD` to `trust` and restart service with `Restart-Service postgresql*`
    - Execute `"alter user postgres with password '[my password]';" | psql -Upostgres`
    - Revert back `data\pg_hba.conf` to METHOD `md5` and restart service

### Virtual package

Each major version has its own package: `postgresql<Version>`

**Virtual package** [postgresql](https://community.chocolatey.org/packages/postgresql) also contains all versions that depend on adequate major version, but using it without problems require some special choco parameters.

To propagate package parameters to dependencies use `--params-global` choco install parameter with virtual package `postgresql`. Assuming latest version is 12, to provide password the following two examples result in identical installation:

```sh
choco install postgresql --params '/Password:test' --params-global
choco install postgresql12 --params '/Password:test'
```

To uninstall dependent package use `--force-dependencies`:

```sh
# The following two examples are identical
choco uninstall postgresql --force-dependencies
choco uninstall postgresql12 postgresql

# This example uninstalls only postgresql virtual package and not postgresql12
choco uninstall postgresql
```

To force reinstallation via virtual package use `--force-dependencies`:

```sh
# The following two examples are identical
choco install postgresql --force --force-dependencies
choco install postgresql12 --force --force-dependencies

# This will reinstall only postgresql virtual package and not its dependency postgresql12
choco install postgresql -force

# This one is different then the first one as vcredist140 dependency is not reinstalled
choco install postgresql12 --force
```

**Please Note**: This is an automatically updated package. If you find it is
out of date by more than a day or two, please contact the maintainer(s) and
let them know [here](https://github.com/mkevenaar/chocolatey-packages/issues) that the package is no longer updating correctly.


## Links

[Chocolatey Package Page](https://community.chocolatey.org/packages/postgresql17)

[Software Site](https://postgresql.org/)

[Package Source](https://github.com/mkevenaar/chocolatey-packages/tree/master/automatic/postgresql)

