imdbid=$1
lang=$2
choice=#3
wget -nv -O Page "https://www.opensubtitles.org/en/search/sublanguageid-$lang/imdbid-$imdbid"
egrep -o "/subtitleserve/sub/[0-9]*" Page >temp
link="https://www.opensubtitles.org/en"
s=`cat temp|tail -n 1 `
final_link="$link$s"
echo "$final_link"
wget -nv -O subtitle.zip --referer "https://www.opensubtitles.org" "$final_link"





