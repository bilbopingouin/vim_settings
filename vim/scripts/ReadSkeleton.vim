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
  endif
endfunction
