#!/bin/bash

TARGET_DIR=~/.vim
UNDODIR=~/.undodir

# Vimrc
com="vim"
for d in $com
do
  echo -n "  Checking ${d}rc.."
  command -v $d >/dev/null 2>&1
  if [ $? -eq 0 ]
  then
    echo " ok."
    list+="${d}rc "
  else
    echo " $d is not installed"
  fi
done

# vim/
com="vim"
for d in $com
do
  echo -n "  Checking ${d}/.."
  command -v $d >/dev/null 2>&1
  if [ $? -eq 0 ]
  then
    echo " ok."
    list+="${d} "
  else
    echo " $d is not installed"
  fi
done

# Setting soft-links
for file in `echo $list`
do
  echo -n "  Setting $file.."
  if [ -L ~/.$file ]
  then
    rm -f ~/.$file
  fi

  if [ ! -e ~/.$file ]
  then
    ln -s $PWD/$file ~/.$file
    echo " ok."
  else
    diff -q ~/.$file $file
  fi
done



# Sets symlink, like for vim
echo "  Setting $TARGET_DIR"
if [ -e $TARGET_DIR ]
then
  echo -n "   Deleting soft-links under $TARGET_DIR.."
  pushd $TARGET_DIR > /dev/null
  find . -type l -delete
  popd > /dev/null
  echo " ok."

  echo "   Setting soft-links"
  # Solarized
  echo -n "    Setting solarized.."
  ln -s  $TARGET_DIR/plugins/solarized/vim-colors-solarized-master/colors/solarized.vim  $TARGET_DIR/colors/solarized.vim
  ln -s  $TARGET_DIR/plugins/solarized/vim-colors-solarized-master/doc/solarized.txt	 $TARGET_DIR/doc/solarized.txt	
  echo " ok."
  # Undotree
  echo -n "    Setting undotree.."
  ln -s  $TARGET_DIR/plugins/undotree/undotree-rel_4.3/./plugin/undotree.vim		 $TARGET_DIR/plugin/undotree.vim 
  ln -s  $TARGET_DIR/plugins/undotree/undotree-rel_4.3/./syntax/undotree.vim		 $TARGET_DIR/syntax/undotree.vim 
  echo " ok."
  # Echo func
  echo -n "    Setting func.."
  ln -s  $TARGET_DIR/plugins/echofunc/echofunc.vim					 $TARGET_DIR/plugin/echofunc.vim 
  echo " ok."
  # fugitive
  echo -n "    Setting fugitive.."
  ln -s  $TARGET_DIR/plugins/fugitive/vim-fugitive/plugin/fugitive.vim			 $TARGET_DIR/plugin/fugitive.vim 
  ln -s  $TARGET_DIR/plugins/fugitive/vim-fugitive/doc/fugitive.txt			 $TARGET_DIR/doc/fugitive.txt
  ln -s  $TARGET_DIR/plugins/fugitive/vim-fugitive/autoload/fugitive.vim		 $TARGET_DIR/autoload/fugitive.vim
  echo " ok."
  # vim games
  echo -n "    Setting games.."
  for file in `find $TARGET_DIR/plugins/vim-games/plugin/* -maxdepth 0`; do ln -s $file $(echo $file | sed -n 's/plugins\/vim-games\///p'); done
  echo " ok."
  # vim-surround
  echo -n "    Setting vim-surround.."
  ln -s $TARGET_DIR/plugins/vim-surround/plugin/surround.vim				 $TARGET_DIR/plugin/surround.vim
  ln -s $TARGET_DIR/plugins/vim-surround/doc/surround.txt				 $TARGET_DIR/doc/surround.txt
  echo " ok."
  # align
  echo -n "    Setting align.."
  for file in `find $TARGET_DIR/plugins/align/plugin/* -maxdepth 0`;	 do ln -s $file $(echo $file | sed -n 's/plugins\/align\///p'); done
  for file in `find $TARGET_DIR/plugins/align/doc/* -maxdepth 0`;	 do ln -s $file $(echo $file | sed -n 's/plugins\/align\///p'); done
  for file in `find $TARGET_DIR/plugins/align/autoload/* -maxdepth 0`;	 do ln -s $file $(echo $file | sed -n 's/plugins\/align\///p'); done
  echo " ok."
  # DrawIt
  echo -n "    Setting DrawIt.."
  ln -s $TARGET_DIR/plugins/drawit/DrawItPlugin.vim					 $TARGET_DIR/plugin/DrawItPlugin.vim
  ln -s $TARGET_DIR/plugins/drawit/DrawIt.txt						 $TARGET_DIR/doc/DrawIt.txt
  ln -s $TARGET_DIR/plugins/drawit/DrawIt.vim						 $TARGET_DIR/autoload/DrawIt.vim
  echo " ok."
  # Vim-Markdown-ToC
  echo -n "    Setting Markdown-ToC.."
  ln -s $TARGET_DIR/plugins/vim-markdown-toc/ftplugin/markdown.vim			 $TARGET_DIR/after/ftplugin/markdown.vim
  ln -s $TARGET_DIR/plugins/vim_markdown-toc/ftdetect/markdown.vim			 $TARGET_DIR/ftdetect/markdown.vim
  echo " ok."
else
  echo "$TARGET_DIR does not exist"
fi

# Undodir
echo -n "  Setting undodir.."
if [ ! -e $UNDODIR ]
then
  mkdir $UNDODIR
  echo " ok."
else
  echo " already there."
fi

