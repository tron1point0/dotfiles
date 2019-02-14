#!/bin/bash

# Use https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_(Select_Graphic_Rendition)_parameters
declare -A types
types=(
["rs"]="0"              # Reset
["di"]="1;38;5;33"      # Directory (Bold, light blue)
["ln"]="4;96"           # Symlink (Underlined, bright cyan)
["ex"]="92"             # File that is executable (Bright green)
["mh"]="36"             # File with more than one hardlink (Dim cyan)
["pi"]="93"             # Pipe (Bright yellow)
["so"]="35"             # Socket (Dim magenta)
["do"]="35"             # Door (Dim magenta)
["bd"]="44;93"          # Block Device (Dark blue bg, bright yellow)
["cd"]="44;33"          # Character Device (Dark blue bg, dim yellow
["or"]="4;91"           # Orphaned link (Underlined, bright red)
["mi"]="0"              # Missing symlink target
["su"]="37;41"          # Setuid (u+s) (Dim red bg, dim grey)
["sg"]="30;43"          # Setgid (g+s) (Dim yellow bg, black)
["ca"]="30;41"          # File with capability (Dim red bg, black)
["tw"]="1;38;5;0;42"    # Dir that is sticky and other-writable (+t,o+w) (Bold, dim green bg, black)
["ow"]="1;38;5;19;42"   # Dir that is other-writable without being sticky (o+w) (Bold, dim green bg, dark blue)
["st"]="1;37;44"        # Dir that is sticky and not other-writable (+t) (Bold, dim blue bg, dim grey)
# Archives / compressed (dim red)
["*.tar"]="31"
["*.tgz"]="31"
["*.arc"]="31"
["*.arj"]="31"
["*.taz"]="31"
["*.lha"]="31"
["*.lz4"]="31"
["*.lzh"]="31"
["*.lzma"]="31"
["*.tlz"]="31"
["*.txz"]="31"
["*.tzo"]="31"
["*.t7z"]="31"
["*.zip"]="31"
["*.z"]="31"
["*.Z"]="31"
["*.dz"]="31"
["*.gz"]="31"
["*.lrz"]="31"
["*.lz"]="31"
["*.lzo"]="31"
["*.xz"]="31"
["*.zst"]="31"
["*.tzst"]="31"
["*.bz2"]="31"
["*.bz"]="31"
["*.tbz"]="31"
["*.tbz2"]="31"
["*.tz"]="31"
["*.deb"]="31"
["*.rpm"]="31"
["*.jar"]="31"
["*.war"]="31"
["*.ear"]="31"
["*.sar"]="31"
["*.rar"]="31"
["*.alz"]="31"
["*.ace"]="31"
["*.zoo"]="31"
["*.cpio"]="31"
["*.7z"]="31"
["*.rz"]="31"
["*.cab"]="31"
# Image formats (dim magenta)
["*.jpg"]="35"
["*.jpeg"]="35"
["*.mjpg"]="35"
["*.mjpeg"]="35"
["*.gif"]="35"
["*.bmp"]="35"
["*.pbm"]="35"
["*.pgm"]="35"
["*.ppm"]="35"
["*.tga"]="35"
["*.xbm"]="35"
["*.xpm"]="35"
["*.tif"]="35"
["*.tiff"]="35"
["*.png"]="35"
["*.svg"]="35"
["*.svgz"]="35"
["*.mng"]="35"
["*.pcx"]="35"
["*.mov"]="35"
["*.mpg"]="35"
["*.mpeg"]="35"
["*.m2v"]="35"
["*.mkv"]="35"
["*.webm"]="35"
["*.ogm"]="35"
["*.mp4"]="35"
["*.m4v"]="35"
["*.mp4v"]="35"
["*.vob"]="35"
["*.qt"]="35"
["*.nuv"]="35"
["*.wmv"]="35"
["*.asf"]="35"
["*.rm"]="35"
["*.rmvb"]="35"
["*.flc"]="35"
["*.avi"]="35"
["*.fli"]="35"
["*.flv"]="35"
["*.gl"]="35"
["*.dl"]="35"
["*.xcf"]="35"
["*.xwd"]="35"
["*.yuv"]="35"
["*.cgm"]="35"
["*.emf"]="35"
# http://wiki.xiph.org/index.php/MIME_Types_and_File_Extensions
["*.ogv"]="35"
["*.ogx"]="35"
# Audio formats (dim cyan)
["*.aac"]="36"
["*.au"]="36"
["*.flac"]="36"
["*.m4a"]="36"
["*.mid"]="36"
["*.midi"]="36"
["*.mka"]="36"
["*.mp3"]="36"
["*.mpc"]="36"
["*.ogg"]="36"
["*.ra"]="36"
["*.wav"]="36"
# http://wiki.xiph.org/index.php/MIME_Types_and_File_Extensions
["*.oga"]="36"
["*.opus"]="36"
["*.spx"]="36"
["*.xspf"]="36"
)

export LS_COLORS=
for key in "${!types[@]}" ; do
    LS_COLORS="$key=${types[$key]}:$LS_COLORS"
done

unset key
unset types
