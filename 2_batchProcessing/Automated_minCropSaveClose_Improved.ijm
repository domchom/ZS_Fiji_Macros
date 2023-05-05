while (nImages > 0) {

	fileName = getInfo("image.filename") ; 
	//saves image name for future use
	dotIndex = indexOf(fileName, ".");  
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	newFileName = fileNameWithoutExtension + "Crop.tif" ;
	
	run("Z Project...", "projection=[Min Intensity]");
	selectWindow("MIN_" + fileName);
	
	run("Z Project...", "projection=[Max Intensity]");	//FOR TWO-CHANNEL DATASETS
	selectWindow("MAX_MIN_" + fileName);				//FOR TWO-CHANNEL DATASETS
	
	setThreshold(1, 65535);
	run("Convert to Mask");
	run("Analyze Particles...", "add");
	selectWindow(fileName);
	roiManager("Select", 0);
	run("Crop");
	saveAs("Tiff","/Volumes/DOM_LS/127DCE_230302_Ect2-GFP_dtom-rGBD_SFC_LS/LS/20230302_154755_DomDC1112boostedcell006xxx230302better/"+newFileName);
	close();
	
	selectWindow("MIN_" + fileName);
	close();
	
	selectWindow("MAX_MIN_" + fileName); 	//FOR TWO-CHANNEL DATASETS
	close();								//FOR TWO-CHANNEL DATASETS
	
	roiManager("Delete");
	
					}


