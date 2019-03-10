# employee_database

Loads [`test_db`](https://github.com/datacharmer/test_db) into a `mysql` database.  App nodes determine query and display it via web server.

## Setup

Install [`chefdk`](https://downloads.chef.io/chefdk/) this can be done by the following ways:
* by installer found [on the website](https://downloads.chef.io/chefdk/)
* with [`brew`](https://brew.sh)
    * `brew cask install chefdk`

Install `Virtual Box` this, also, can be done by the following ways:
* by installer found [on the website](https://www.virtualbox.org/wiki/Downloads)
* with [`brew`](https://brew.sh)
    * `brew cask install virtualbox`

Install [`vagrant`](https://www.vagrantup.com/) this be done:
* by installer found [on the website](https://www.vagrantup.com/downloads.html)
* with [`brew`](https://brew.sh)
    * `brew cask install vagrant`

## Run in `Test Kitchen`

Set local shell to use `chef_shell`:
`eval "$(chef shell-init bash)"`

Run `Test Kitchen` setup with:
`kitchen converge`

View webpage at [`192.168.0.11`](http://192.168.0.11)