#!/bin/bash

TARGET_DIR=~/.vim
UNDODIR=~/.undodir

# Simlink
for file in `find * -maxdepth 0 -type f -not -path ".git/" -not -name "set_links.sh"`
do
  if [ -L ~/.$file ]
  then
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


# Sets symlink, like for vim
if [ -L $TARGET_DIR ]
then 
  echo " Delete $TARGET_DIR link"
  rm -f $TARGET_DIR
fi

if [ ! -e $TARGET_DIR ]
then
  echo " Set $TARGET_DIR link"
  ln -s $PWD/vim $TARGET_DIR
  
  cd $TARGET_DIR
  echo "Found links:"
  find . -type l -ls
  find . -type l -delete
  cd -

  # Adding some directories
  for dir in autoload
  do
    if [ ! -e $TARGET_DIR/$dir ]
    then
      mkdir $TARGET_DIR/$dir
    fi 
  done

  # Solarized
  ln -s  $TARGET_DIR/plugins/solarized/vim-colors-solarized-master/colors/solarized.vim  $TARGET_DIR/colors/solarized.vim
  ln -s  $TARGET_DIR/plugins/solarized/vim-colors-solarized-master/doc/solarized.txt	 $TARGET_DIR/doc/solarized.txt	
  # Undotree
  ln -s  $TARGET_DIR/plugins/undotree/undotree-rel_4.3/./plugin/undotree.vim		 $TARGET_DIR/plugin/undotree.vim 
  ln -s  $TARGET_DIR/plugins/undotree/undotree-rel_4.3/./syntax/undotree.vim		 $TARGET_DIR/syntax/undotree.vim 
  # Echo func
  ln -s  $TARGET_DIR/plugins/echofunc/echofunc.vim					 $TARGET_DIR/plugin/echofunc.vim 
  # fugitive
  ln -s  $TARGET_DIR/plugins/fugitive/vim-fugitive/plugin/fugitive.vim			 $TARGET_DIR/plugin/fugitive.vim 
  ln -s  $TARGET_DIR/plugins/fugitive/vim-fugitive/doc/fugitive.txt			 $TARGET_DIR/doc/fugitive.txt
  ln -s  $TARGET_DIR/plugins/fugitive/vim-fugitive/autoload/fugitive.vim		 $TARGET_DIR/autoload/fugitive.vim
  # vim games
  for file in `find $TARGET_DIR/plugins/vim-games/plugin/* -maxdepth 0`; do ln -s $file $(echo $file | sed -n 's/plugins\/vim-games\///p'); done
  # vim-surround
  ln -s $TARGET_DIR/plugins/vim-surround/plugin/surround.vim				 $TARGET_DIR/plugin/surround.vim
  ln -s $TARGET_DIR/plugins/vim-surround/doc/surround.txt				 $TARGET_DIR/doc/surround.txt
  # align
  for file in `find $TARGET_DIR/plugins/align/plugin/* -maxdepth 0`;	 do ln -s $file $(echo $file | sed -n 's/plugins\/align\///p'); done
  for file in `find $TARGET_DIR/plugins/align/doc/* -maxdepth 0`;	 do ln -s $file $(echo $file | sed -n 's/plugins\/align\///p'); done
  for file in `find $TARGET_DIR/plugins/align/autoload/* -maxdepth 0`;	 do ln -s $file $(echo $file | sed -n 's/plugins\/align\///p'); done
  # DrawIt
  ln -s $TARGET_DIR/plugins/drawit/DrawItPlugin.vim					 $TARGET_DIR/plugin/DrawItPlugin.vim
  ln -s $TARGET_DIR/plugins/drawit/DrawIt.txt						 $TARGET_DIR/doc/DrawIt.txt
  ln -s $TARGET_DIR/plugins/drawit/DrawIt.vim						 $TARGET_DIR/autoload/DrawIt.vim
else
  echo "$TARGET_DIR should be set manually: not a softlink"
fi

if [ ! -e $UNDODIR ]
then
  mkdir $UNDODIR
fi
