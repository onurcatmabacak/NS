wget https://www.atnf.csiro.au/people/pulsar/psrcat/downloads/psrcat_pkg.tar.gz
gunzip psrcat_pkg.tar.gz
tar -xvf psrcat_pkg.tar
cd psrcat_tar
source makeit
ROOT=/home/onur/Dev/HEAL/PulsarCatalogue
$ROOT/psrcat_tar/psrcat -db_file $ROOT/psrcat_tar/psrcat.db -c "name p0" -l "p0 > 3"
