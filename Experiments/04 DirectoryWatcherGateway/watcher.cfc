component {

	function onChange( cfevent ) {
		writeLog( text="CHANGE on " & cfevent.data.filename, file="cfless" );
		var cfless = new cfless().compileLessFile(cfevent.data.filename);
	}

}