#! /bin/bash

function MuonCalib()
{
	runNrFile='../configs/DataTakingDB_202409_CAEN.csv'
	echo "=================================================================================="
	echo "option $1"
	echo "run Nr Pedestal: $2"
	echo "run Nr Muon: $3"
	echo "dataRawDir: $4"
	echo "dataOutDir: $5"
	echo "OutNameRun:" $6
	if [ $1 == "transfer" ]; then 
		echo "badchannelMap:" $7
	fi
	echo "=================================================================================="
	if [ $1 == "transfer" ]; then 
		./Analyse -d 1 -e -f -P $5/PedestalCalib_$2.root -i $4/raw_$3.root -o $4/rawPed_$3.root -r ../configs/DataTakingDB_202409_CAEN.csv -O ../PlotsCalibTransfer_2024/$6 -r $runNrFile
	elif [ $1 == "default" ]; then 
		time ./Analyse -f -d 1  -s -i $4/rawPed_$3.root -o $5/rawPedAndMuon_$3.root -O ../PlotsCalibMuon_2024/$6 -r $runNrFile
	elif [ $1 == "improved" ]; then 
		time ./Analyse -f -d 1  -S -i $5/rawPedAndMuon_$3.root -o $5/rawPedAndMuonImp_$3.root -O ../PlotsCalibMuonImproved_2024/$6 -r $runNrFile
	elif [ $1 == "improved2nd" ]; then 
		./Analyse -f -d 1  -S -i $5/rawPedAndMuonImp_$3.root -o $5/rawPedAndMuonImp2nd_$3.root -O ../PlotsCalibMuonImproved_2024/$6_2ndIte -r $runNrFile
	elif [ $1 == "improved3rd" ]; then 
		./Analyse -f -d 1  -S -i $5/rawPedAndMuonImp2nd_$3.root -o $5/rawPedAndMuonImp3rd_$3.root -O ../PlotsCalibMuonImproved_2024/$6_3rdIte -r $runNrFile
	elif [ $1 == "transferWithBC" ]; then 
		time ./Analyse -d 1 -a -e -f -P $5/PedestalCalib_$2.root -i $4/raw_$3.root -o $4/rawPedWBC_$3.root -B $7 -O ../PlotsCalibTransferBC_2024/$6 -r $runNrFile
	elif [ $1 == "defaultWithBC" ]; then 
		time ./Analyse -e -a -f -d 1  -s -i $4/rawPedWBC_$3.root -o $5/rawPedAndMuonWBC_$3.root -O ../PlotsCalibMuonBC_2024/$6 -r $runNrFile
	elif [ $1 == "improvedWBC" ]; then 
		time ./Analyse -f -d 1 -a -S -i $5/rawPedAndMuonWBC_$3.root -o $5/rawPedAndMuonWBCImp_$3.root -O ../PlotsCalibMuonImprovedBC_2024/$6 -r $runNrFile
	elif [ $1 == "improvedWBC2nd" ]; then 
		time ./Analyse -f -d 1 -a -S -i $5/rawPedAndMuonWBCImp_$3.root -o $5/rawPedAndMuonWBCImp2nd_$3.root -O ../PlotsCalibMuonImprovedBC_2024/$6_2ndIte -r $runNrFile
	elif [ $1 == "improvedWBC3rd" ]; then 
		time ./Analyse -f -d 1 -a -S -i $5/rawPedAndMuonWBCImp2nd_$3.root -o $5/rawPedAndMuonWBCImp3rd_$3.root -O ../PlotsCalibMuonImprovedBC_2024/$6_3rdIte -r $runNrFile
	elif [ $1 == "improvedWBC4th" ]; then 
		time ./Analyse -f -d 1 -a -S -i $5/rawPedAndMuonWBCImp3rd_$3.root -o $5/rawPedAndMuonWBCImp4th_$3.root -O ../PlotsCalibMuonImprovedBC_2024/$6_4thIte -r $runNrFile
	elif [ $1 == "noise" ]; then 
		./Analyse -f -d 1  -n -i $5/rawPedAndMuon_$3.root -o $5/rawPedAndMuonNoise_$2.root -O ../PlotsCalibNoiseRe_2024/$6 -r $runNrFile
	elif [ $1 == "transferAlt" ]; then 
		./Analyse -d 1  -f -P $5/rawPedAndMuonNoise_$3.root -i $4/raw_$3.root -o $4/rawPedImp_$3.root -r $runNrFile
	elif [ $1 == "defaultImpPed" ]; then 
		./Analyse -f -d 1  -s -i $4/rawPedImp_$3.root -o $5/rawPedImpAndMuon_$3.root -O ../PlotsCalibMuonPedImp_2024/$6 -r $runNrFile
	elif [ $1 == "saveNewPed" ]; then 
		./Analyse -f -d 1 -N -i $5/rawPedAndMuonNoise_$3.root -o $4/raw_pedonly_$3.root 
	elif [ $1 == "saveNewMuon" ]; then 
		time ./Analyse -f -d 1 -M -i $5/rawPedAndMuon_$3.root -o $4/raw_muononly_$3.root 
	elif [ $1 == "improvedMinimal" ]; then 
		time ./Analyse -f -d 1  -S -i $4/raw_muononly_$3.root -o $5/rawPedAndMuonImpMinimal_$2.root -O ../PlotsCalibMuonImproved_2024/$6_MinimalSet -r $runNrFile
	elif [ $1 == "improvedMinimal2nd" ]; then 
		time ./Analyse -f -d 1  -S -i $5/rawPedAndMuonImpMinimal_$3.root -o $5/rawPedAndMuonImpMinimal2nd_$3.root -O ../PlotsCalibMuonImproved_2024/$6_MinimalSet2nd -r $runNrFile
	elif [ $1 == "improvedMinimal3rd" ]; then 
		time ./Analyse -f -d 1  -S -i $5/rawPedAndMuonImpMinimal2nd_$3.root -o $5/rawPedAndMuonImpMinimal3rd_$3.root -O ../PlotsCalibMuonImproved_2024/$6_MinimalSet3rd -r $runNrFile
	fi
}


dataDirRaw=""
dataDirOut=""
if [ $1 = "fbock" ]; then 
	dataDirRaw=/media/fbock/Samsung_T5/LFHCAL_TB/202408_PST09/CAENdata/MuonRuns
	dataDirOut=/home/fbock/EIC/Analysis/LFHCalTB2024/CAENdata/MuonRuns
else
	echo "Please select a known user name, otherwise I don't know where the data is"
	exit
fi

# pedestal runs 
pedestalRuns='303 306 308 311 315 271 277 420 454 528 552 553 332 369 377 404 465 476 492 505 521'

# pedestalRuns='420'
if [ $2 = "pedestal" ]; then
	for runNr in $pedestalRuns; do
		./Analyse -d 1 -p -i $dataDirRaw/raw_$runNr.root -f -o $dataDirOut/PedestalCalib_$runNr.root -O ../PlotsCalib_2024/Run$runNr -r ../configs/DataTakingDB_202409_CAEN.csv
	done;
fi

if [ $2 == "mergemuons" ]; then
# 	hadd -f $dataDirRaw/raw_muonScanA1_45V.root $dataDirRaw/raw_244.root $dataDirRaw/raw_250.root
# 	hadd -f $dataDirRaw/raw_muonScanA2_45V.root $dataDirRaw/raw_283.root $dataDirRaw/raw_282.root
	hadd -f $dataDirRaw/raw_muonScanD1_45V.root $dataDirRaw/raw_412.root $dataDirRaw/raw_417.root
# 	hadd -f $dataDirRaw/raw_muonScanD2_45V.root $dataDirRaw/raw_460.root $dataDirRaw/raw_456.root $dataDirRaw/raw_457.root
# 	hadd -f $dataDirRaw/raw_muonScanH1_45V.root $dataDirRaw/raw_526.root $dataDirRaw/raw_527.root
# 	hadd -f $dataDirRaw/raw_muonScanH2_45V.root $dataDirRaw/raw_554.root $dataDirRaw/raw_559.root
# 	hadd -f $dataDirRaw/raw_muonScanB1_42V.root $dataDirRaw/raw_331.root $dataDirRaw/raw_322.root
# 	hadd -f $dataDirRaw/raw_muonScanB2_42V.root $dataDirRaw/raw_370.root $dataDirRaw/raw_371.root $dataDirRaw/raw_374.root
# 	hadd -f $dataDirRaw/raw_muonScanC1_43_5V.root $dataDirRaw/raw_376.root $dataDirRaw/raw_375.root
# 	hadd -f $dataDirRaw/raw_muonScanC2_43_5V.root $dataDirRaw/raw_405.root $dataDirRaw/raw_410.root $dataDirRaw/raw_408.root
# 	hadd -f $dataDirRaw/raw_muonScanE1_40V.root $dataDirRaw/raw_464.root $dataDirRaw/raw_463.root
# 	hadd -f $dataDirRaw/raw_muonScanE2_40V.root $dataDirRaw/raw_481.root $dataDirRaw/raw_478.root
# 	hadd -f $dataDirRaw/raw_muonScanF1_41V.root $dataDirRaw/raw_486.root $dataDirRaw/raw_489.root
# 	hadd -f $dataDirRaw/raw_muonScanF2_41V.root $dataDirRaw/raw_507.root $dataDirRaw/raw_506.root
# 	hadd -f $dataDirRaw/raw_muonScanG_46V.root $dataDirRaw/raw_508.root $dataDirRaw/raw_510.root $dataDirRaw/raw_511.root $dataDirRaw/raw_525.root
fi


# # muon runs different scans in groups with separate pedestal
#50.3 events
muonHVScan_44V='305'
pedHVScan_44V='303'
if [ $2 == "muoncalibHV" ] || [ $2 == "muoncalibHV44" ]; then
	echo "running muon calib for 44V runs"
		MuonCalib $3 $pedHVScan_44V $muonHVScan_44V $dataDirRaw $dataDirOut muonHVScan_44V ../configs/badChannelMap_TBSetup_202308_Run305.txt
fi

#50.1K events
muonHVScan_43V='307'
pedHVScan_43V='306'
if [ $2 == "muoncalibHV" ] || [ $2 == "muoncalibHV43" ]; then
	echo "running muon calib for 43V runs"
	MuonCalib $3 $pedHVScan_43V $muonHVScan_43V $dataDirRaw $dataDirOut muonHVScan_43V ../configs/badChannelMap_TBSetup_202308_Run305.txt
fi

#50.6K events
muonHVScan_42V='309'
pedHVScan_42V='308'
if [ $2 == "muoncalibHV" ] || [ $2 == "muoncalibHV42" ]; then
	echo "running muon calib for 42V runs"
	MuonCalib $3 $pedHVScan_42V $muonHVScan_42V $dataDirRaw $dataDirOut muonHVScan_42V ../configs/badChannelMap_TBSetup_202308_Run305.txt
fi

#51K events
muonHVScan_41V='312'
pedHVScan_41V='311'
if [ $2 == "muoncalibHV" ] || [ $2 == "muoncalibHV41" ]; then
	echo "running muon calib for 41V runs"
	MuonCalib $3 $pedHVScan_41V $muonHVScan_41V $dataDirRaw $dataDirOut muonHVScan_41V ../configs/badChannelMap_TBSetup_202308_Run305.txt
fi

#50.8K events
muonHVScan_40V='316'
pedHVScan_40V='315'
if [ $2 == "muoncalibHV" ] || [ $2 == "muoncalibHV40" ]; then
	echo "running muon calib for 40V runs"
	MuonCalib $3 $pedHVScan_40V $muonHVScan_40V $dataDirRaw $dataDirOut muonHVScan_40V ../configs/badChannelMap_TBSetup_202308_Run305.txt
fi

muonScanA_45V='244 250 282 283'
pedScanA_45V='271 277'
if [ $2 == "muoncalibAll" ] || [ $2 == "muoncalibA" ]; then
	# 192K events
	echo "running muon calib for 45V runs, campaing A1"
	MuonCalib $3 271 muonScanA1_45V $dataDirRaw $dataDirOut muonScanA1_45V

	# 201.6K events
	echo "running muon calib for 45V runs, campaing A2"
	MuonCalib $3 277 muonScanA2_45V $dataDirRaw $dataDirOut muonScanA2_45V
fi

#102.2K events
muonScanD1_45V='412 417'
pedScanD1_45V='420'
if [ $2 == "muoncalibAll" ] || [ $2 == "muoncalibD1" ]; then
	echo "running muon calib for 45V runs, campaing D1"
	MuonCalib $3 $pedScanD1_45V muonScanD1_45V $dataDirRaw $dataDirOut muonScanD1_45V
fi

# 29.3K events
muonScanD2_45V='460 456 457'
pedScanD2_45V='454'
if [ $2 == "muoncalibAll" ] || [ $2 == "muoncalibD2" ]; then
	echo "running muon calib for 45V runs, campaing D2"
	MuonCalib $3 $pedScanD2_45V muonScanD2_45V $dataDirRaw $dataDirOut muonScanD2_45V
fi

# 50.6K events 2nd column underrespresented
muonScanH1_45V='526 527'
pedScanH1_45V='528'
if [ $2 == "muoncalibAll" ] || [ $2 == "muoncalibH" ]; then
	echo "running muon calib for 45V runs, campaing H1"
	MuonCalib $3 $pedScanH1_45V muonScanH1_45V $dataDirRaw $dataDirOut muonScanH1_45V
fi

#33.5K events 1st-2nd column only
muonScanH2_45V='554 559'
# pedScanH2_45V='552 553'
pedScanH2_45V='552'
if [ $2 == "muoncalibAll" ] || [ $2 == "muoncalibH" ]; then
	echo "running muon calib for 45V runs, campaing H2"
	MuonCalib $3 $pedScanH2_45V muonScanH2_45V $dataDirRaw $dataDirOut muonScanH2_45V
fi

# 202.6K events
muonScanB1_42V='331 322'
pedScanB1_42V='332'
if [ $2 == "muoncalibAll" ] || [ $2 == "muoncalibB1" ]; then
	echo "running muon calib for 42V runs, campaing B1"
	MuonCalib $3 $pedScanB1_42V muonScanB1_42V $dataDirRaw $dataDirOut muonScanB1_42V
fi

# 214.8k events
muonScanB2_42V='370 371 374'
pedScanB2_42V='369'
if [ $2 == "muoncalibAll" ] || [ $2 == "muoncalibB2" ]; then
	echo "running muon calib for 42V runs, campaing B2"
	MuonCalib $3 $pedScanB2_42V muonScanB2_42V $dataDirRaw $dataDirOut muonScanB2_42V
fi

# 240.2K events
muonScanC1_43_5V='376 375'
pedScanC1_43_5V='377'
if [ $2 == "muoncalibAll" ] || [ $2 == "muoncalibC1" ]; then
	echo "running muon calib for 43.5V runs, campaing C1"
	MuonCalib $3 $pedScanC1_43_5V muonScanC1_43_5V $dataDirRaw $dataDirOut muonScanC1_43_5V
fi
muonScanC2_43_5V='405 410 408'
pedScanC2_43_5V='404'
if [ $2 == "muoncalibAll" ] || [ $2 == "muoncalibC" ]; then
	echo "running muon calib for 43.5V runs, campaing C2"
	MuonCalib $3 $pedScanC2_43_5V muonScanC2_43_5V $dataDirRaw $dataDirOut muonScanC2_43_5V
fi

# 40.7K events
muonScanE1_40V='463 464'
pedScanE1_40V='465'
if [ $2 == "muoncalibAll" ] || [ $2 == "muoncalibE" ]; then
	echo "running muon calib for 40V runs, campaing E1"
	MuonCalib $3 $pedScanE1_40V muonScanE1_40V $dataDirRaw $dataDirOut muonScanE1_40V
fi

muonScanE2_40V='481 478'
pedScanE2_40V='476'
if [ $2 == "muoncalibAll" ] || [ $2 == "muoncalibE" ]; then
	MuonCalib $3 $pedScanE2_40V muonScanE2_40V $dataDirRaw $dataDirOut muonScanE2_40V
fi

# 22.6K events
muonScanF1_41V='486 489'
pedScanF1_41V='492'
if [ $2 == "muoncalibAll" ] || [ $2 == "muoncalibF1" ]; then
	echo "running muon calib for 41V runs, campaing F1"
	MuonCalib $3 $pedScanF1_41V muonScanF1_41V $dataDirRaw $dataDirOut muonScanF1_41V ../configs/badChannelMap_TBSetup_202308_Run305.txt
fi

# 42.8K events
muonScanF2_41V='507 506'
pedScanF2_41V='505'
if [ $2 == "muoncalibAll" ] || [ $2 == "muoncalibF" ]; then
	echo "running muon calib for 41V runs, campaing F2"
	MuonCalib $3 $pedScanF2_41V muonScanF2_41V $dataDirRaw $dataDirOut muonScanF2_41V		
fi

# 101.7K events
muonScanG_46V='508 510 511 525'
pedScanG_46V='521'
if [ $2 == "muoncalibAll" ] || [ $2 == "muoncalibG" ]; then
	echo "running muon calib for 46V runs, campaing G"
	MuonCalib $3 $pedScanG_46V muonScanG_46V $dataDirRaw $dataDirOut muonScanG_46V		
fi

