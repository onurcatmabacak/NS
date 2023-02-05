#Appendix A: The Pulsar Parameters

#Name:        Pulsar name.  The B name if exists, otherwise the J name.
#JName:       Pulsar name based on J2000 coordinates
#RAJ:         Right ascension (J2000) (hh:mm:ss.s) 
#DecJ:        Declination (J2000) (+dd:mm:ss) 
#PMRA:        Proper motion in the right ascension direction (mas/yr) 
#PMDec:       Proper motion in declination (mas/yr) 
#PX:          Annual parallax (mas) 
#PosEpoch:    Epoch at which the position is measured (MJD) 
#ELong:       Ecliptic longitude (degrees)
#ELat:        Ecliptic latitude (degrees) 
#PMElong:     Proper motion in the ecliptic longitude direction (mas/yr) 
#PMElat:      Proper motion in ecliptic latitude (mas/yr) 
#GL:          Galactic longitude (degrees) 
#GB:          Galactic latitude (degrees) 
#RAJD:        Right ascension (J2000) (degrees)
#DecJD:       Declination (J2000) (degrees)

#Timing solution and profile parameters:

#P0:          Barycentric period of the pulsar (s)
#P1:          Time derivative of barcycentric period (dimensionless)
#F0:          Barycentric rotation frequency (Hz)
#F1:          Time derivative of barycentric rotation frequency (s-2)
#F2:          Second time derivative of barycentric rotation frequency (s-3)
#F3:          Third time derivative of barycentric rotation frequency (s-4)
#PEpoch:      Epoch of period or frequency (MJD)
#DM:          Dispersion measure (cm-3 pc)
#DM1:         First time derivative of dispersion measure (cm-3 pc yr-1)
#RM:          Rotation measure (rad m-2)
#W50:         Width of pulse at 50% of peak (ms). Note, pulse widths are a function of both observing frequency and
#             observational time resolution,so quoted widths are indicative only. Refer to the original reference for details.
#W10:         Width of pulse at 10% (ms). Note the comments above for W50.
#Units:       Timescale for pulse period/frequency data: TCB or TDB.
#Tau_sc:      Temporal broadening of pulses at 1 GHz due to interestellar scattering (s)
#S400:        Mean flux density at 400 MHz (mJy)
#S1400:       Mean flux density at 1400 MHz (mJy)
#S2000:       Mean flux density at 2000 MHz (mJy)

#Binary system parameters:

#Binary:      Binary model (usually one of several recognised by the pulsar timing programs TEMPO or TEMPO2

#T0:          Epoch of periastron (MJD)
#PB:          Binary period of pulsar (days)
#A1:          Projected semi-major axis of orbit (lt s)
#OM:          Longitude of periastron (degrees)
#ECC:         Eccentricity
#TASC:        Epoch of ascending node(MJD) - ELL1 binary model
#EPS1:        ECC x sin(OM) - ELL1 binary model
#EPS2:        ECC x cos(OM) - ELL1 binary model
#MinMass:     Minimum companion mass assuming i=90 degrees and neutron star mass is 1.35 Mo
#MedMass:     Median companion mass assuming i=60 degrees
#BinComp:     Companion type

#Distance parameters:

#Dist:        Best estimate of the pulsar distance using the tc93 DM-based distance as default (kpc)
#Dist_DM:     Distance based on the tc93 electron density model. 
#             In 'LONG' or 'PUBLICATION QUALITY' modes, lower limits from the distance model are preceded by a '+' sign.
#DMsinb:      DM x sin(b) (cm-3 pc)
#ZZ:          Distance from the Galactic plane, based on Dist
#XX:          X-Distance in X-Y-Z Galactic coordinate system (kpc)
#YY:          Y-Distance in X-Y-Z Galactic coordinate system (kpc)
#Associations and survey parameters:

#Assoc:       Names of other objects, e.g., supernova remnant, globular cluster or gamma-ray source 
#             associated with the pulsar
#Survey:      Surveys that detected the pulsar (discovery survey first). Click here for currently defined surveys.
#OSurvey:     Surveys that detected the pulsar encoded as bits in integer
#Date:        Date of discovery publication.
#Type:        Type codes for the pulsar. Click here for available types.
#NGlt:        Number of glitches observed for the pulsar

#Derived parameters:

#R_Lum:       Radio luminosity at 400 MHz (mJy kpc2)
#R_Lum14:     Radio luminosity at 1400 MHz (mJy kpc2)
#Age:         Spin down age (yr) []
#BSurf:       Surface magnetic flux density (Gauss) []
#Edot:        Spin down energy loss rate (ergs/s)
#Edotd2:      Energy flux at the Sun (ergs/kpc2/s)
#PMTot:       Total proper motion (mas/yr)
#VTrans:      Transverse velocity - based on DIST (km/s)
#P1_i:        Period derivative corrected for Shklovskii (proper motion) effect 
#Age_i:       Spin down age from P1_i (yr)
#BSurf_i:     Surface magnetic dipole from P1_i (gauss)
#B_LC:        Magnetic field at light cylinder

#Appendix B: Pulsar Types

#AXP	Anomalous X-ray Pulsar or Soft Gamma-ray Repeater with detected pulsations
#BINARY	Pulsar has one or more stellar companion(s)
#HE	Spin-powered pulsar with pulsed emission from radio to infrared or higher frequencies
#NRAD	Spin-powered pulsar with pulsed emission only at infrared or higher frequencies
#RADIO	Pulsars with pulsed emission in the radio band
#RRAT	Pulsars with intermittently pulsed radio emission
#XINS	Isolated neutron stars with pulsed thermal X-ray emission but no detectable radio emission

#Appendix C: Binary Companion Types

#MS	Main-sequence star
#NS	Neutron star
#CO	CO or ONeMg White Dwarf
#He	Helium White Dwarf
#UL	Ultra-light companion or planet (mass < 0.08 solar masses)
ROOT=/home/onur/Dev/HEAL/PulsarCatalogue
$ROOT/psrcat_tar/psrcat -db_file $ROOT/psrcat_tar/psrcat.db -c "name jname p0 p1 p1_i pb bincomp minmass medmass age ag_i bsurf bsurf_i edot r_lum r_lum14 c1 c2" -c1 "r_lum / edot * 3.81e34" -c2 "r_lum14 / edot * 1.33e35" -l "(c1 >= 0.1) || (c2 >= 0.1)" > $ROOT/pulsar_mhe.txt
