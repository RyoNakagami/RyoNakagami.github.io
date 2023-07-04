---
layout: post
title: "Check the log file to find out the source of the problem"
subtitle: "Server Trouble Shooting 1/N"
author: "Ryo"
header-mask: 0.0
header-style: text
catelog: true
mathjax: true
revise_date: 2023-06-29
tags:

- Linux
- trouble shooting
---

<div style='border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>

<p class="h4">&nbsp;&nbsp;Table of Contents</p>

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- ["Manhattan": can't write data into database, SadServers](#manhattan-cant-write-data-into-database-sadservers)
  - [Solution](#solution)
- [Understand Logging](#understand-logging)
  - [Where is the log files stored?:  `/var/log/`](#where-is-the-log-files-stored--varlog)
- [`journalctl` command](#journalctl-command)
  - [Basic Log Viewing](#basic-log-viewing)
- [References](#references)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->


</div>

## "Manhattan": can't write data into database, SadServers

<div style='padding-left: 2em; padding-right: 2em; border-radius: 1em; border-style:solid; border-color:#D3D3D3; background-color:#F8F8F8'>
<p class="h4"><ins>Problem settings</ins></p>

Your objective is to be able to insert a row in an existing Postgres database using the follwoing script:

```bash
$ sudo -u postgres psql -c "insert into persons(name) values ('jane smith');" -d dt
```

And if it returns `INSERT 0 1`, then it will be successful.


- Postgres is managed by systemd as a unit with name `postgresql`.
- `postgresql` writes to disk in a data directory, the location of which is defined in the data_directory parameter of the configuration file `/etc/postgresql/14/main/postgresql.conf`.

</div>

### Solution


First, I will use the systemctl command to start the PostgreSQL service and try on the specified command:

```bash
$ systemctl start postgresql
$ sudo -u postgres psql -c "insert into persons(name) values ('jane smith');" -d dt
psql: error: connection to server on socket "/var/run/postgresql/.s.PGSQL.5432" failed: No such file or directory
        Is the server running locally and accepting connections on that socket?
```

The error message suggests "Is the server running locally".
To verify whether the PostgreSQL service is running or not, I will utilize `systemctl list-units --type=service` command

```bash
systemctl list-units --type=service | grep "postgres"
  postgresql.service                 loaded active     exited        PostgreSQL RDBMS                                                  
● postgresql@14-main.service         loaded failed     failed        PostgreSQL Cluster 14-main  
```

Now, we are aware that the PostgreSQL service is not running. 
To identify the cause of the service failure, it is advisable to consistently monitor the log files.

So, let's go to `/var/log` directory:

```bash
$ cd /var/log
$ ls
alternatives.log       cloud-init.log   dpkg.log.1     messages.1     syslog.6.gz
alternatives.log.1     daemon.log       dpkg.log.2.gz  messages.2.gz  sysstat
apt                    daemon.log.1     dpkg.log.3.gz  messages.3.gz  unattended-upgrades
auth.log               daemon.log.2.gz  dpkg.log.4.gz  messages.4.gz  user.log
auth.log.1             daemon.log.3.gz  faillog        postgresql     user.log.1
auth.log.2.gz          daemon.log.4.gz  kern.log       private        user.log.2.gz
auth.log.3.gz          debug            kern.log.1     syslog         user.log.3.gz
auth.log.4.gz          debug.1          kern.log.2.gz  syslog.1       user.log.4.gz
btmp                   debug.2.gz       kern.log.3.gz  syslog.2.gz    wtmp
btmp.1                 debug.3.gz       kern.log.4.gz  syslog.3.gz
chrony                 debug.4.gz       lastlog        syslog.4.gz
cloud-init-output.log  dpkg.log         messages       syslog.5.gz
```

We have discovered PostgreSQL directory. We are planning to investigate and analyze a log file located within that directory.

```bash
$ cd ./postgresql/
$ ls
postgresql-14-main.log    postgresql-14-main.log.2.gz  postgresql-14-main.log.4.gz
postgresql-14-main.log.1  postgresql-14-main.log.3.gz  postgresql-14-main.log.5.gz
$ cat postgresql-14-main.log
pg_ctl: could not start server
Examine the log output.
2023-07-04 03:38:26.968 UTC [775] FATAL:  could not create lock file "postmaster.pid": No space left on device
pg_ctl: could not start server
Examine the log output.
```

It appears that the source of the problem is the lack of available space on the device where the PostgreSQL service is operating.
We need to determine the directory where the PostgreSQL service is using as its data directory.

```bash
$ cat /etc/postgresql/14/main/postgresql.conf| grep "data_directory"
#data_directory = '/var/lib/postgresql/14/main'         # use data in another directory
data_directory = '/opt/pgdata/main'             # use data in another directory
```

It appears that the data directory of the PostgreSQL service is located at `opt/pgdata/main`/
We will assess the amount of space utilized in that directory.

```bash
$ df /opt/pgdata/main
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/nvme0n1     8378368 8378340        28 100% /opt/pgdata

$ cd /opt/pgdata 
du -shx ./*
4.0K    ./deleteme
7.0G    ./file1.bk
923M    ./file2.bk
488K    ./file3.bk
50M     ./main
```

We discovered that the backup files occupy a significant portion of the available space, leading to the issue of insufficient space.
The files in question are redundant temporary files, and their removal would not cause any adverse effects. Once these files are removed, we will assess the current usage status.

```bash
$ rm /opt/pgdata/file*.bk
$ df /opt/pgdata/main
Filesystem     1K-blocks  Used Available Use% Mounted on
/dev/nvme0n1     8378368 92728   8285640   2% /opt/pgdata
```

Then, restart postgresql service.


```bash
$ systemctl restart postgresql
$ ps aux | grep "postgresql"
postgres   903  0.1  5.8 211064 27688 ?        Ss   03:47   0:00 /usr/lib/postgresql/14/bin/postgres -D /opt/pgdata/main -c config_file=/etc/postgresql/14/main/postgresql.conf
root       923  0.0  0.1   4964   820 pts/0    S+   03:47   0:00 grep postgresql

$ systemctl list-units --type=service | grep "postgres"
postgresql.service                 loaded active exited  PostgreSQL RDBMS                                                  
postgresql@14-main.service         loaded active running PostgreSQL Cluster 14-main   
```

"It appears that the PostgreSQL service is functioning smoothly without any issues.

```
sudo -u postgres psql -c "insert into persons(name) values ('jane smith');" -d dt
INSERT 0 1
```


## Understand Logging

As seen above, when the service is not running, you can check the log file to understand what kind of errors are occurring, and by doing so, you will be able to address the problem.

If you have any kind of problem, the log files will show you some very important info. So it's a good idea to know how to get to and view log files.

### Where is the log files stored?:  `/var/log/`

When you move to the root directory, you can find a `/var` directory.
`/var` directory usually contains data that is shared and used by all users and applications. In many cases, the log files are stored in `/var/log/` directory.

`/var/log` directory serves as a centralized location for storing logs generated by the system, system services, daemons, and applications. Each log file typically corresponds to a specific component or service running on the system. 

In Ubuntu, typical examples of log files stored in the `/var/log` directory include the following:

---|---
`/var/log/syslog`|Contains general system messages from various sources, including the kernel, daemons, and other system services
`/var/log/kern.log`| Records kernel-related messages and events
`/var/log/auth.log`|Contains authentication-related logs, including login attempts and user authentication
`/var/log/dmesg`|Displays kernel ring buffer messages from the most recent system startup


Additionally, log files for specific system services and daemons, such as `/var/log/apache2`, `/var/log/mysql` and sithers, are stored in `/var/log` as well.

> `var/log/syslog` vs `var/log/messages`

Traditionally, the `/var/log/messages` file was used to store general system log messages in many Linux distributions. But you may not find this file if you are ubuntu user. In some Linux distributions, including Ubuntu, the `/var/log/messages` file might not be present by default, and it is not commonly used as it once was.

Instead, many distributions have shifted towards using other log files like `/var/log/syslog` for centralizing system log messages.

## `journalctl` command

`journalctl` command is specific to `systemd`.

`systemd` is a system and service manager that has become the standard initialization system for many modern Linux distributions. you can think of it as the init system. It is responsible for starting and managing system services, handling system startup and shutdown processes, and maintaining the overall health of the system. The system that collects and manages these logs is known as the `journal`.

The `journalctl` command is used to query and view logs managed by `journald` component. 

### Basic Log Viewing

When used alone, every journal entry that is in the system will be displayed within a pager for you to browse. The oldest entries will be up top:

```zsh
% journalctl
-- Logs begin at Tue 2023-02-03 21:48:52 UTC, end at Tue 2023-06-03 22:29:38 UTC. --
Feb 03 21:48:52 localhost.localdomain systemd-journal[243]: Runtime journal is using 6.2M (max allowed 49.
Feb 03 21:48:52 localhost.localdomain systemd-journal[243]: Runtime journal is using 6.2M (max allowed 49.
Feb 03 21:48:52 localhost.localdomain systemd-journald[139]: Received SIGTERM from PID 1 (systemd).
Feb 03 21:48:52 localhost.localdomain kernel: audit: type=1404 audit(1423000132.274:2): enforcing=1 old_en
Feb 03 21:48:52 localhost.localdomain kernel: SELinux: 2048 avtab hash slots, 104131 rules.
Feb 03 21:48:52 localhost.localdomain kernel: SELinux: 2048 avtab hash slots, 104131 rules.
Feb 03 21:48:52 localhost.localdomain kernel: input: ImExPS/2 Generic Explorer Mouse as /devices/platform/
Feb 03 21:48:52 localhost.localdomain kernel: SELinux:  8 users, 102 roles, 4976 types, 294 bools, 1 sens,
Feb 03 21:48:52 localhost.localdomain kernel: SELinux:  83 classes, 104131 rules
...
```

All of the timestamps being displayed are local time. If you want to display the timestamps in UTC, you can use the `--utc` option:

```zsh
% journalctl --utc
```W

### Use-cases for `journalctl` command

> Check Boot logging

This will show you all of the journal entries that have been collected since the most recent reboot:

```zsh
& journalctl -b
```

> Filtering by Time

You have the flexibility to filter logs with specific time constraints using the `--since` and `--until` options. 
These options allow you to limit the displayed log entries to those after or before the specified time, respectively.

```zsh
% journalctl --since "2023-01-10" --until "2023-01-11 03:00"
```

> Filtering by Unit

We can do filtering by the unit you are interested in. For instance, to see all of the logs from a `bluetooth.service` unit on our system, we can type:

```zsh
% journalctl -u bluetooth.service
```


## References

- [SadServers >  "Manhattan": can't write data into database](https://sadservers.com/newserver/manhattan#)
- [How To Use Journalctl to View and Manipulate Systemd Logs](https://www.digitalocean.com/community/tutorials/how-to-use-journalctl-to-view-and-manipulate-systemd-logs)