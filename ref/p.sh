#!/bin/sh

# ARRAY=( "cow:moo"
#         "dinosaur:roar"
#         "bird:chirp"
#         "bash:rock" )

# for animal in "${ARRAY[@]}" ; do
#     KEY="${animal%%:*}"
#     VALUE="${animal##*:}"
#     printf "%s likes to %s.\n" "$KEY" "$VALUE"
# done

# printf "%s is an extinct animal which likes to %s\n" "${ARRAY[1]%%:*}" "${ARRAY[1]##*:}"
# =======================================================================================
# FILENAME="enter filename here"

# while read LINE
# do
#   var1=$(echo "$LINE" | awk '{print $1}')
#   var2=$(echo "$LINE" | awk '{print $2}')

# done < $FILENAME

# ===========================================================================================

# for a in `df -H | awk '{print $1}'` and for b in `df -H | awk '{print $1}'`;
# do
#     echo a=$a, b=$b
#     echo ============

# done
# # ===============================
# IFS=" "
# while read a b
# do
#        # do stuff
#     echo a=$a, b=$b
# done < fh.log
# unset IFS
# # ===============================
# ===============================
#  read a b <<< `df -H | awk '{print $1" "$3}'`
#  echo a=$a | b=$b


# # ===============================
# ex:
# files=`find <subdir> -name '*'`
# while read -r fname; do
#     echo $fname
# done <<< "$files"
# # ===============================
# #!/bin/bash
# while read -r fname; do
#     echo $fname
# done <<< "`find <subdir> -name '*'`"
# # ===============================

# ===================================================================
# = function with dump disk available space then assign to variables
# ===================================================================
# ---------- Method 1 ----------------
# df -H | awk '{print $2, $3}' | while read var1 var2
# do
#     echo "var1=$var1 | var2=$var2"
# done


# ---------- Method 2 ----------------
while read var1 var2
do
    echo "var1=$var1 | var2=$var2"
done <<< "`df -H | awk '{print $2, $3}'`"



