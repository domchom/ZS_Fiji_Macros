//This macro creates difference movies from multi-channel movies
differenceNumber = getNumber("how many frames do you want to subtract?", 5) ; // default 5 frames

while (nImages > 0) {
	getDimensions(width, height, channels, slices, frames) ;		
	//gets and saves the movie dimensions for later use
	fileName = getInfo("image.title"); 
	//gets and saves the file name for later
	
	path = getInfo("image.directory");  // use the source directory...
	//path = "/Users/bementmbp/Desktop" // ...or paste a custom save path

	imageName = getInfo("image.filename") ; 
	//saves image name for future use
	dotIndex = indexOf(imageName, ".");  
	//this and the following line get the file name without the extension
	fileNameWithoutExtension = substring(imageName, 0, dotIndex); 
	//this and the above line get the file name without the extension
	newFileName = fileNameWithoutExtension + "_Diff" + differenceNumber + ".tif" ;

	counter = 1 ;//creates a counter variable that starts as 1 and increases by 1 with every trip through the loop
	while (counter <= channels) {  //runs a loop as long as the there are still channels left to duplicate
		Stack.setChannel(counter); //moves to channel x (whatever the x number through the loop is)
		run("Duplicate...", "title=Channel_" + counter + " duplicate channels=" + counter);
		//duplicates the active channel and renames it "Channel_X"
		setSlice(1);
		run("Duplicate...", "title=firstDup duplicate");
		run("Duplicate...", "title=lastDup duplicate");
		selectWindow("firstDup") ;
		for (i=1; i<=differenceNumber; i++) { //runs a loop
			run("Delete Slice");    //changes the slice for each position in the loop
		}
		selectWindow("lastDup") ;
		run("Reverse");
		for (i=1; i<=differenceNumber; i++) { //runs a loop
			run("Delete Slice");    //changes the slice for each position in the loop
		}
		run("Reverse");
		imageCalculator("Subtract create 32-bit stack", "firstDup","lastDup");
		selectWindow("firstDup") ;
		close() ; //closes first intermediate
		selectWindow("lastDup") ;
		close() ; //closes last intermediate
		selectWindow("Channel_" + counter);
		close(); //closes the duplicated channel selection
		selectWindow("Result of firstDup") ;
		rename("C" + counter) ; //renames difference movie to the channel it was generated from
		getMinAndMax(min, max) ; // if you want to internally normalize...
		setMinAndMax(0, 65536) ; //thresholds the video 
		run("16-bit");
		run("Enhance Contrast", "saturated=0.35");
		selectWindow(fileName);
		counter += 1; //loops through again
	}
	
	if (channels == 2) {
		run("Merge Channels...", "c1=C1 c2=C2 create");
	} //merges two channels together
	
	if (channels == 3) {
		run("Merge Channels...", "c1=C1 c2=C2 c3=C3 create");
	} //merges 3 channels together
	
	if (channels == 4) {
		run("Merge Channels...", "c1=C1 c2=C2 c3=C3 c4=C4 create");
	} //merges 4 channels together
	
	if (channels == 1) {
		selectWindow("C1");
	} 
	saveAs("Tiff","/Volumes/DOM_FIVE/132DCE_230329_IT-Rho-noGDI-SFC/processed/crop_diff/"+newFileName);
	close();
	selectWindow(fileName);	
	close();
					}