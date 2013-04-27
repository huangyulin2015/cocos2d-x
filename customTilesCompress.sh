#!/bin/sh
 
function scandir() {
    local cur_dir parent_dir workdir
    workdir=$1
    cd ${workdir}
    if [ ${workdir} = "/" ]
    then
        cur_dir=""
    else
        cur_dir=$(pwd)
    fi
 
    for dirlist in $(ls ${cur_dir})
    do
        if test -d ${dirlist};then
            cd ${dirlist}
            scandir ${cur_dir}/${dirlist}
            cd ..
        else
            if [ "${dirlist##*.}" = "png" ]; then
                echo ${cur_dir}/${dirlist}
                basename=`basename ${dirlist} .png`
                texturePacker --allow-free-size --no-trim --disable-rotation --shape-padding 0 --border-padding 0 --opt RGB565 ${dirlist} --sheet $basename.pvr.ccz
                rm ${dirlist};
            fi
        fi
    done
    rm out.plist
}
 

 for i in `ls`; do
     if [ -d $i ]; then
         echo "start handle ----$i ----directory";
         scandir $i
         cd ..
     fi
 done