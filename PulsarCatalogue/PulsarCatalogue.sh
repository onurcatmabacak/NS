gunzip psrcat_pkg.tar.gz
tar -xvf psrcat_pkg.tar
cd psrcat_tar
source makeit
$HOME/psrcat_tar/psrcat -db_file $HOME/psrcat_tar/psrcat.db -c "name p0" -l "p0 > 3"
