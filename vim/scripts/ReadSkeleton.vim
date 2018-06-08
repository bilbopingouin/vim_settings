"==============================================================================
" Include some pre-defined templates into the text
"==============================================================================
" Author: (web)
" Original date: (web)
" Modification history:
"    Date   |  Name        | Comments
"  ---------|--------------|-------------------------------
"           |              |
"==============================================================================
" Available commands:
"  call SetTemplValues()	 -- Set some values from the templates
"  call ReadSkeleton()           -- See the available templates and insert it
"==============================================================================
" Notes
"   http://vim.1045645.n5.nabble.com/How-to-insert-text-via-script-function-call-td1153378.html
"==============================================================================

function! SetTemplValues()
  if search("|YEAR|") != 0
    :echo "Substitute |YEAR|"
    :%s/|YEAR|/\=strftime("%Y")/g
  endif

  if search("|DATE|") != 0
    :echo "Substitute |DATE|"
    :%s/|DATE|/\=strftime("%Y-%m-%d")/g
  endif

  if search("TIME") != 0
    :echo "Substitute |TIME|"
    :%s/|TIME|/\=strftime("%H:%M")/g
  endif

  if search("|FILENAME|") != 0
    :echo "Substitute |FILENAME|"
    :%s/|FILENAME|/\=expand("%:t")/g
  endif

  if search("|MODULE|") != 0
    :echo "Substitute |MODULE|"
    :%s/|MODULE|/\=input("Module name: ")/g
    :echo "."
  endif

  if search("|AUTHOR|") != 0
    :echo "Substitute |AUTHOR|"
    if exists("g:author_name") != 0
      :%s/|AUTHOR|/\=expand(g:author_name)/g
    else
      :%s/|AUTHOR|/\=input("Author name: ")/g
      :echo "."
    endif
  endif

  if search("|AUTHSHORT|") != 0
    :echo "Substitute |AUTHSHORT|"
    if exists("g:author_short") != 0
      :%s/|AUTHSHORT|/\=expand(g:author_short)/g
    else
      :%s/|AUTHSHORT|/\=input("Author short name: ")/g
      :echo "."
    endif
  endif
 
  if search("|EMAIL|") != 0
    :echo "Substitute |EMAIL|"
    if exists("g:author_short") != 0
      :%s/|EMAIL|/\=expand(g:author_email)/g
    else
      :%s/|EMAIL|/\=input("Email address: ")/g
      :echo "."
    endif
  endif


  if search("|COMPANY|") != 0
    :echo "Substitute |COMPANY|"
    if exists("g:author_short") != 0
      :%s/|COMPANY|/\=expand(g:author_company)/g
    else
      :%s/|COMPANY|/\=input("Company name: ")/g
      :echo "."
    endif
  endif

  if search("<CURSOR>") != 0
    :echo "Reaching <CURSOR>"
    :call search("<CURSOR>")
    :normal 8x
    :startinsert
  endif
endfunction


function! ReadSkeleton()
  if exists ("g:Skeleton_path")
    let skeleton_path = g:Skeleton_path
  else
    let skeleton_path = getcwd()
  endif

  "echo skeleton_path

  let filenameList = split (glob ( skeleton_path . "/*.*") , "\n")
  let filenameList = insert (filenameList, "Select skeleton to load")
  let choiceList = copy (filenameList)
  let choiceList = map (choiceList, 'index(filenameList,v:val) .". ". v:val')
  let choiceList[0] = "Select skeleton to load"
  let listLen = len(choiceList)
  let choiceList = add (choiceList, listLen . ". Browse for some other folder (gui ONLY)")
  let choice = inputlist(choiceList)
  "echo choice
  let skeletonName = ""
  if choice == listLen
    "Do the browse thingie if possible
    if has("browse")
      let skeletonName = browse(0,"Select session to restore",skeleton_path,"")
      echo skeletonName
    endif
  elseif choice > 0
    "Load the file
    let skeletonName = filenameList[choice]
    echo "setting skeletonName to ".skeletonName
  endif
  if skeletonName != ""
    execute "0read " . skeletonName
    call SetTemplValues()
  endif
endfunction
