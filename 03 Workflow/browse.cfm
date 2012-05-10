<cfscript>
	param demo="./";
	parentPath = reverse(listRest(reverse(demo), "/")) & "/";
	fullPath = expandPath(demo);

	if (structKeyExists(url,"deleteoutput")) {
		try{fileDelete("#fullPath#output.css");} catch(any e) {}
		try{fileDelete("#fullPath#output-min.css");} catch(any e) {}
	}

	dir = directoryList(fullPath, false, "query");

	try {
		readme = fileRead("#fullPath#readme.txt");
	} catch (any e) {
		readme = "";
	}
</cfscript>

<cfcontent reset="true"><!doctype html>
<html lang="en">
<head>
	<title>LESS CSS, Meet ColdFusion Demos</title>
	<link rel="stylesheet/less" type="text/css" href="../demo.less" />
	<script src="../less-1.3.0.min.js"></script>
</head>
<body>
<cfoutput>
	<nav>
		<a href="./">&laquo; workflows</a>
		<cfif len(parentPath) gt 3><a href="#cgi.script_name#?demo=#parentPath#">&##x25b2; directory</a></cfif>
	</nav>
	<h1>Workflow for #reReplace(listLast(demo, "/"), "^\d+\s*", "")#</h1>
	<cfif len(readme)><p>#readme#</p></cfif>
</cfoutput>
	<pre><cfoutput query="dir">#chr(13)#
<cfif type EQ "file">#rJustify(dateFormat(dir.DateLastModified, "short"), 12)# #rJustify(timeFormat(dir.DateLastModified, "short"), 9)#   #rJustify(dir.Size, 10)#  <a href="#demo##dir.name#">#dir.Name#</a> (<a href="code.cfm?sourcefile=#demo##dir.name#">code</a>) <cfif reFindNoCase("^build.*\.xml$", dir.name)>(<a href="Ant.cfm?sourcefile=#demo##dir.name#">Ant</a>)</cfif> <cfif dir.name EQ "output.css">(<a href="#cgi.script_name#?#cgi.query_string#<cfif cgi.query_string does not contain 'deleteoutput'>&deleteoutput=true</cfif>">delete</a>)</cfif></cfif>

</cfoutput></pre>

</body>
</html>