for file in *' '*
do
	mv -i -- "$file" "${file// /_}"
done
