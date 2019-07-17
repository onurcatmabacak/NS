for((i=1;i<301;i++)) 
do 
echo "cd $HOME/Desktop/Onur/Deltanu_constant/R_in_eq_R_Alfven && gfortran 4_Sources.f95 -o 4_Sources_$i && echo $i | ./4_Sources_$i"
done > 4_Sources_Sample.sh

cat 4_Sources_Sample.sh | parallel -j 8 --progress

cd $HOME/Desktop/Onur/Deltanu_constant/R_in_eq_R_Alfven
for((i=1;i<301;i++)) 
do 
rm 4_Sources_$i
done

gfortran 4_Sources_DataMan.f95 -o 4_Sources_DataMan && ./4_Sources_DataMan
gfortran 4_Sources_GammaPhi.f95 -o 4_Sources_Gammaphi && ./4_Sources_GammaPhi
#rm Mass*.dat
