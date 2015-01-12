#!/bin/bash

#dir= ~/cfg_backup_`date +%F`
#mkdir $dir

# Simlink
for file in `find * -maxdepth 0 -type f -not -path ".git/"`
do
  if [ -L ~/.$file ]
  then
    echo " Update: $file"
    rm -f ~/.$file
    ln -s $PWD/$file ~/.$file
  else
    if [ ! -e ~/.$file ]
    then
      ln -s $PWD/$file ~/.$file
    else
      diff -q ~/.$file $file
    fi
  fi
done

dirs='aptitude elinks oh-my-zsh'
for d in $dirs
do
  echo "dir: $d"

  if [ ! -e ~/.$d ]
  then
    mkdir ~/.$d
  fi

  for file in `find $d -type f`
  do
    if [ -L ~/.$file ]
    then
      echo " Update: $file"
      rm -f ~/.$file
      ln -s $PWD/$file ~/.$file
    else
      if [ ! -e ~/.$file ]
      then
	ln -s $PWD/$file ~/.$file
      else
	diff -q ~/.$file $file
      fi
    fi
  done
done


# Sets symlink, like for vim
if [ -L ~/.vim ]
then 
  rm -f ~/.vim
  ln -s $PWD/vim ~/.vim
  
  cd ~/.vim
  echo "Found links:"
  find . -type l -ls
  find . -type l -delete
  cd -
  ln -s  ~/.vim/plugins/solarized/vim-colors-solarized-master/colors/solarized.vim     ~/.vim/colors/solarized.vim
  ln -s  ~/.vim/plugins/undotree/undotree-rel_4.3/./plugin/undotree.vim		  ~/.vim/plugin/undotree.vim 
  ln -s  ~/.vim/plugins/echofunc/echofunc.vim					  ~/.vim/plugin/echofunc.vim 
  ln -s  ~/.vim/plugins/fugitive/vim-fugitive/plugin/fugitive.vim			  ~/.vim/plugin/fugitive.vim 
  ln -s  ~/.vim/plugins/solarized/vim-colors-solarized-master/doc/solarized.txt	  ~/.vim/doc/solarized.txt	
  ln -s  ~/.vim/plugins/fugitive/vim-fugitive/doc/fugitive.txt			  ~/.vim/doc/fugitive.txt	
  ln -s  ~/.vim/plugins/undotree/undotree-rel_4.3/./syntax/undotree.vim		  ~/.vim/syntax/undotree.vim 
else
  echo "~/.vim should be set manually: not a softlink"
fi
