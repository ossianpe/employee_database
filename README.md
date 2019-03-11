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

Install [`Vagrant`](https://www.vagrantup.com/) this be done:
* by installer found [on the website](https://www.vagrantup.com/downloads.html)
* with [`brew`](https://brew.sh)
    * `brew cask install vagrant`

Install [`kitchen-vagrant`]:
    * `chef gem install kitchen-vagrant`

## Utilizing `Test Kitchen`
## Running

1) Set local shell to use `chef_shell`:
    `eval "$(chef shell-init bash)"`

1) Run `Test Kitchen` setup with:
    `kitchen converge`

1) Wait for infrastructure to be built.

1) Once the infrastructure is built, view load balancer at [`192.168.0.15`](http://192.168.0.15)

### Testing

In order to run tests, run the following:
`kitchen verify <suite_name>`
_where <suite_name> is the name of the node_

For example:
`kitchen verify database`

### Clean up

Once finished with building and testing infrastructure, run the following command to remove everything:

`kitchen destroy`