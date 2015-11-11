# vim_settings
My set of configuration files for vim

Since some time using vim, I wrote some configuration files, and I wanted to 
1) have them easily accessible for me
2) offer the other people to gain something from it.

Note that it is an on-going thing, and it is not perfect. In particular the language syntax
files are made, with on-going knowledge. So the later are probably better than the previous ones.

Cleanup may occur at some point, but not yet.

Comments are welcome.

###########################

Installation Procedure
----------------------

On Linux, run the following

  - backup your existing configuration

	```
        cd $HOME
        tar -cvjf vim_cfg_backup.tar.bz2 ./.vim*
	```

  - get the source

	```
    mkdir my_configuration_dir
    cd my_configuration_dir
    git clone https://github.com/bilbopingouin/vim_settings.git
    cd vim_settings
    git submodule init
    git submodule update
	```

  - install

    
	```
    cd my_configuration_dir/vim_settings
    ./set_links.sh
	```

All the configuration files are organised using soft-links. Also the .vim repository will be soft-link to the current one.

On Windows, you should find out by yourself.

Notes
-----

  - Learn git
  - Feedback is welcome
  - Patches will be considered
