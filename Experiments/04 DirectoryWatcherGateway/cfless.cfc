<cfcomponent hint="cause less is more! This file will transfer less files into a single css file">

	<cffunction name="compileLessFile" hint="Compiles a single .less file into a .css file">
		<cfargument name="lessfile" hint="File absolute path" />
		<cfset var thisPath = getDirectoryFromPath(getCurrentTemplatePath()) />
		<cfset var destinationFile = reReplaceNoCase(arguments.lessfile, "\.less$", ".css") />

		<cfset var oJS = CreateObject("component", "js").init() />
		<cfset oJS.addScriptFromFile(thisPath & "browser.js") />
		<cfset oJS.addScriptFromFile(thisPath & "less.js") />
		<cfset oJS.addScriptFromFile(thisPath & "engine.js") />

		<cfset var line = "">
		<cfset var lessCssContent = "">

		<cfloop file="#lessFile#" index="line">
			<cfif reFindNoCase( "@import.*\.less", line )>
				<!--- We need to get the import file and place it lessCssContent --->
				<cfset lessCssContent &= chr(13) & chr(10)>
				<cfset lessCssContent &= fileRead( getDirectoryFromPath( lessFile ) & ReReplaceNoCase( line, "^(.*""|')(.*)(""|'.*);.*$", "\2" ) )>
				<cfset lessCssContent &= chr(13) & chr(10)>
			<cfelse>
				<cfset lessCssContent &= line>
				<cfset lessCssContent &= chr(13) & chr(10)>
			</cfif>
		</cfloop>

		<cfset var outputCSS = oJS.compileString( lessCssContent ) />
		<cfset fileWrite( destinationFile, outputCSS ) />
	</cffunction>

	<cffunction name="compileLessFolder" hint="Compiles a folder of .less files into .css files">
		<cfargument name="directory" hint="Starting folder absolute path" />

		<cfset var dir = directoryList(arguments.directory, true, "query", "*.less") />
		<cfloop query="dir">
			<cfoutput>Compiling #name#<br/></cfoutput>
			<cfset compileLessFile(dir.directory & "/" & dir.name) />
		</cfloop>
	</cffunction>

</cfcomponent>