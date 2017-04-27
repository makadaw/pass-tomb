# pass tomb [![build][build-img]][build-url] [![coverage][cover-img]][cover-url] [![climate][clima-img]][clima-url]

A [pass](https://www.passwordstore.org/) extension that helps to keep the whole
tree of password encrypted inside a tomb.

## Description

Due to the structure of `pass`, file- and directory names are not encrypted in
the password store. `pass-tomb` provides a convenient solution to put your password
store in a [tomb](https://github.com/dyne/Tomb) and then keep your password
tree encrypted when you are not using it.

It uses the same GPG key to encrypt passwords and tomb.

The new workflow is the following:
* Create a password tomb with `pass tomb`
 - Create a new tomb and open it in `~/.password-store`
 - Initialise the password store with the same GPG key
* Use tomb as usual
* When finished, close the password tomb: `pass close`
* To use pass again, you need to open the password tomb: `pass open`

## Examples

**Create a new password tomb**
```
$ pass tomb <gpg-id>
 (*) Your password tomb has been created and opened in ~/.password-store.
 (*) Password store initialized for <gpg-id>
  .  Your tomb is: ~/password
  .  Your tomb key is: ~/password.key
  .  You can now use pass as usual
  .  When finished, close the password tomb using 'pass close'
```

**Open a password tomb**
```
$ pass open
 (*) Your password tomb has been opened in ~/.password-store.
  .  You can now use pass as usual.
  .  When finished, close the password tomb using 'pass close'.
```

**Close a password tomb**
```
$ pass close
 (*) Your password tomb has been closed.
  .  Your passwords remain present in ~/password.
  ```

## Usage

		Usage:
		    pass tomb [--path=subfolder,-p subfolder] gpg-id...
		        Create and initialise a new password tomb
		        Use gpg-id for encryption of both tomb and passwords
		    pass open
		        Open a password tomb
		    pass close
		        Close a password tomb

		Options:
		    -v, --verbose  Print tomb message
		    -d, --debug    Print tomb debug message
		          --unsafe   Speed up tomb creation (for testing purposes only)
		    -V, --version  Show version information.
		    -h, --help	     Print this help message and exit.

		More information may be found in the pass-tomb(1) man page.


See `man pass-tomb` for more information.

## Environment Variables

* `PASSWORD_STORE_TOMB`: path to `tomb` executable
* `PASSWORD_STORE_TOMB_FILE`: path to the password tomb (default: `~/password`)
* `PASSWORD_STORE_TOMB_KEY`: path to the password tomb key file (default: `~/password.key`)
* `PASSWORD_STORE_TOMB_SIZE`: password tomb size in MB (default: `10`)

## Installation

**ArchLinux**

		pacaur -S pass-tomb

**Other linuxes**

		git clone https://github.com/roddhjav/pass-tomb/
		cd pass-tomb
		sudo make install

**Requirments**

* `tomb 2.4` or greater.

* `pass 1.7.0` or greater.

* If you do not want to install this extension as system extension, you need to
enable user extension with `PASSWORD_STORE_ENABLE_EXTENSIONS=true pass`. You can
create an alias in `.bashrc`: `alias pass='PASSWORD_STORE_ENABLE_EXTENSIONS=true pass'`


## Contribution
Feedback, contributors, pull requests are all very welcome.


## License

    Copyright (C) 2017  Alexandre PUJOL

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

[build-img]: https://travis-ci.org/roddhjav/pass-tomb.svg?branch=master
[build-url]: https://travis-ci.org/roddhjav/pass-tomb
[cover-img]: https://coveralls.io/repos/github/roddhjav/pass-tomb/badge.svg?branch=master
[cover-url]: https://coveralls.io/github/roddhjav/pass-tomb?branch=master
[clima-img]: https://codeclimate.com/github/roddhjav/pass-tomb/badges/gpa.svg
[clima-url]: https://codeclimate.com/github/roddhjav/pass-tomb
