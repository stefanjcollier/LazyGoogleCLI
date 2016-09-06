function print {
    echo Google: ${1}
}

URL="https://www.google.co.uk/search?q="
function go_search {
    local address=${URL}${1}
    print "Going to ${address}"
    open /Applications/Google\ Chrome.app $address
}

# Replaces all spaces with plusses
function fix {
    echo $* | sed 's/ /\+/g'
}

# Removes the first arguement
function rem_arg {
    echo $* | awk '{ $1=""; print $0 }'
}

# Search Google via 'Web'
function web_search {
    go_search `fix $*`
}

IMG_POSTFIX="&tbm=isch&source=lnms"
function image_search {
    go_search "`fix $*`${IMG_POSTFIX}"
}

VID_POSTFIX="&tbm=vid&source=lnms"
function video_search {
    go_search "`fix $*`${VID_POSTFIX}"
}

MAPS_ADDRESS="http://maps.google.com/?q="
function maps_search {
    address="${MAPS_ADDRESS}`fix $*`"
    print "Going to ${address}"
    open /Applications/Google\ Chrome.app $address
}

DIRECTIONS_ADDRESS="http://www.google.com/maps/dir/"
function direction_search {
    echo dwdnowdn
    src=`awk -FS'--'  '{print $1 }' $*`
    echo aaa
    dst=`awk -FS'--'  '{print $2 }' $*`
    echo bbb
    address="${DIRECTIONS_ADDRESS}${src}//${dst}//"
    echo ccc
    echo "eifef"    
    print "Going to ${address}"
    open /Applications/Google\ Chrome.app $address
}

STACK_POSTFIX="+site:stackoverflow.com"
function stack_overflow_search {
    go_search "`fix $*`${STACK_POSTFIX}"
}



if [ -z $1 ]; then
    print "You need to google something"
    exit 0
fi

case $1 in 
	"-i" | "--image" )
    image_search `rem_arg $*`
;;
	"-v" | "--video" )
    video_search `rem_arg $*`
;;
	"-s" | "--stack" )
    stack_overflow_search `rem_arg $*`
;;
	"-m" | "--maps" )
    maps_search  `rem_arg $*`
;;
	"-d" | "--dirs" |"--directions" )
    direction_search  `rem_arg $*`
;;
	*)
    web_search $*
;;
esac


