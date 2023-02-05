for((i=1;i<301;i++)) 
do 
echo "cd $HOME/Desktop/LevenbergMarquardt/ && gfortran 4_Sources.f90 -o 4_Sources_$i && echo $i | ./4_Sources_$i"
done > 4_Sources_Sample.sh

cat 4_Sources_Sample.sh | parallel -j 30 --progress

for((i=1;i<301;i++)) 
do 
cd $HOME/Desktop/LevenbergMarquardt/ && rm 4_Sources_$i
done


