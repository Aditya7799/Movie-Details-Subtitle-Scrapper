echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "\n "
echo -e "\n"

echo "                                                                                           MOVIE and TV SHOWS DETAILS"
echo -e "\n "
echo -e "\n "
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""
echo ""                                   

echo "enter the name of the movie or the TV show"
read movie

# =========================================================
# the website being used for scraping 
# =========================================================
wget -O detail.txt "http://www.omdbapi.com/?apikey=72287f09&t=$movie"
# cat detail.txt

# =========================================================================
# checking if the file has been downloaded successfully from the website
# =========================================================================

echo ""
if [ -f detail.txt ]
then
	echo -e "\n INFORMATION RETREIVAL SUCCESSFUL"
else
	echo "Either the movie does not exist in the database,so check your internet connection or enter the correct spelling again"
	# bash unixproj.sh
fi

# ====================================================================
# removig all the unwanted characters to bring it to readable format
# ====================================================================

sed -r -i 's/(\{|\})/ /g' detail.txt 
sed -r -i 's/",/\n \n/g' detail.txt 
sed -r -i 's/"/ /g' detail.txt 
sed -r -i 's/\]/ /g' detail.txt
sed -r -i 's/\[/\n/g' detail.txt
# sed -r -i 's/ /\b/1' emp.lsts
# cat detail.txt
# =========================================================
# getting the imdbid from the downloaded JSON file
# =========================================================

grep "imdbID" detail.txt > imdbid.txt
sed -r -i "s/imdbID//g" imdbid.txt
sed -r -i "s/ //g" imdbid.txt
sed -r -i "s/://g" imdbid.txt

# ====================================================
# deleting lines which contains unwanted information
# ====================================================

sed -r -i '/Type/d' detail.txt
sed -r -i '/Response/d' detail.txt
# sed -r -i '/Poster/d' detail.txt
sed -r -i '/Website/d' detail.txt
sed -r -i 's/(^ )//g' detail.txt
sed -r -i 's/^$/\n************************************************************************************************************************************************************************************************************\n /g' detail.txt
sed -r -i '1s/T/************************************************************************************************************************************************************************************************************\nT/g' detail.txt
sed -r -i 's/(^ )//g' detail.txt
sed -r -i 's/\*/\-/g' detail.txt

# =========================================================
# using grep to obtain the link for downloading the poster
# =========================================================

grep "Poster" detail.txt > posterurl.txt
sed -r -i 's/Poster : //g' posterurl.txt
sed -r -i '/Poster/d' posterurl.txt
wget -O "$movie.jpg" `cat posterurl.txt`
# mkdir posters
mkdir "Database/$movie"

#===========================================================
#moving file to corresponding database folder
#===========================================================

mv "$movie.jpg" "Database/$movie"
# cat detail.txt

# =========================================================
# printing only important information on the server pc
# =========================================================

head -n 25 detail.txt
echo "check movie_details directory for more info"

# =========================================================
# moving the details file to a directory 
# =========================================================

mv detail.txt "$movie.txt"
# mkdir movie_details
mv "$movie.txt" "Database/$movie"

# =========================================================
# getting the language for subtitle
# =========================================================

echo "enter language for the subtitle file"
read language
bash subtitle.sh `cat imdbid.txt` "$language"
mv subtitle.zip "Database/$movie"







 





