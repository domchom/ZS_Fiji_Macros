
while (nImages > 0) {

	fileName = getInfo("image.filename") ; 
	//saves image name for future use
	path = getDirectory("image") ;
	//saves path that the image is saved to
	dotIndex = indexOf(fileName, ".");  
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(fileName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	newFileName = fileNameWithoutExtension + "_Reg.tif" ;

	fullPath = path + "/" + newFileName;
	//creates a save path for the newly created file
	
	//makeRectangle(96, 28, 338, 462);
	//run("Crop");	

	run("StackReg ", "transformation=Translation");


	run("Enhance Contrast", "saturated=0.15");
	
	saveAs("Tiff","/Volumes/DOM_LS/120DCE_230125_Ect2-Mgc-Plk1-SFC/reg/"+newFileName);	
	//save(fullPath) ;
	close();
	
					}