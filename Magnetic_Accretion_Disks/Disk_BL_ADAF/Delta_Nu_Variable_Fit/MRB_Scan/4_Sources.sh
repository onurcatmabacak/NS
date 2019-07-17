for((i=1;i<301;i++)) 
do 
echo "cd $HOME/Desktop/Onur/Delta_Nu_Variable_Fit/MRB_Scan && gfortran 4_Sources.f95 -o 4_Sources_$i && echo $i | ./4_Sources_$i"
done > 4_Sources_Sample.sh

cat 4_Sources_Sample.sh | parallel -j 32 --progress

for((i=1;i<301;i++)) 
do 
cd $HOME/Desktop/Onur/Delta_Nu_Variable_Fit/MRB_Scan && rm 4_Sources_$i
done

cd $HOME/Desktop/Onur/Delta_Nu_Variable_Fit/MRB_Scan
gfortran 4_Sources_DataMan.f95 -o 4_Sources_DataMan
./4_Sources_DataMan

for((i=1;i<301;i++)) 
do 
cd $HOME/Desktop/Onur/Delta_Nu_Variable_Fit/MRB_Scan && rm Mass_$i.dat
done
