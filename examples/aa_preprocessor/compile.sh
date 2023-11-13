AaPreprocess -I src/ src/toplevel.aa -o tmp 
vcFormat < tmp > preprocessed.aa 
rm tmp
