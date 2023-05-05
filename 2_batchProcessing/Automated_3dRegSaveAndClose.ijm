
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

	run("Re-order Hyperstack ...", "channels=[Slices (z)] slices=[Channels (c)] frames=[Frames (t)]");
	run("PoorMan3DReg ", "transformation=Translation number=2 projection=[Max Intensity]");
	run("Re-order Hyperstack ...", "channels=[Slices (z)] slices=[Channels (c)] frames=[Frames (t)]");

	Stack.setDisplayMode("composite");
	Stack.setChannel(1);
	run("Green");
	run("Enhance Contrast", "saturated=0.15");
	Stack.setChannel(2);
	run("Magenta");
	run("Enhance Contrast", "saturated=0.15");
	
	saveAs("Tiff","/Volumes/DOM_LS/129DCE_230316_Rho-IT-waves-SFC/processed/t-series/raw_regcrop/"+newFileName);	
	//save(fullPath) ;
	close();
	
					}