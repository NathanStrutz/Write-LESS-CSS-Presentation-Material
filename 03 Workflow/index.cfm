<cfscript>

	dir = directoryList(expandPath("./"), false, "query");
	dirName = listLast(expandPath("./"), "\");
	demoNumber = numberFormat(listFirst(dirName, " "));
	demoName = listLast(dirName, " ");

</cfscript>

<cfcontent reset="true"><!doctype html>
<html lang="en">
<head>
	<title>Write LESS CSS Demos</title>
	<link rel="stylesheet/less" type="text/css" href="../demo.less" />
	<script src="../less-1.1.3.min.js"></script>
</head>
<body>
<nav>
	<a href="../">&laquo; demos</a>
</nav>
<h1><cfoutput>Demo #demoNumber#: LESS ColdFusion #demoName#</cfoutput></h1>
<ol>
	<cfoutput query="dir">
		<cfif type EQ "dir">
			<li><a href="browse.cfm?demo=#name#/">#reReplace(name, "^\d+\s*", "")#</a></li>
		</cfif>
	</cfoutput>
</ol>
</body>
</html>