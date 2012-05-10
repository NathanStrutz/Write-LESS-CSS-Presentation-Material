<cfscript>
	param demo="./";
	parentPath = reverse(listRest(reverse(demo), "/")) & "/";
	fullPath = expandPath(demo);
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
	<link rel="stylesheet/less" type="text/css" href="demo.less" />
	<script src="less-1.3.0.min.js"></script>
</head>
<body>
<cfoutput>
<nav>
	<a href="index.html">&laquo; demos</a> <cfif len(demo) gt 3><a href="demo.cfm?demo=#parentPath#">&##x25b2; directory</a></cfif>
</nav>
<h1>LESS CF Experiment 1</h1>
<cfif len(readme)><p>#htmlCodeFormat(readme)#</p></cfif>
</cfoutput>
<pre><cfoutput query="dir">#chr(13)#
<cfif type EQ "file">#rJustify(dateFormat(dir.DateLastModified, "short"), 12)# #rJustify(timeFormat(dir.DateLastModified, "short"), 9)#   #rJustify(dir.Size, 10)#  <a href="#demo##dir.name#">#dir.Name#</a> <cfif listFindNoCase("cfm,xml,html,htm", listLast(dir.name, "."))>(<a href="code.cfm?sourcefile=#demo##dir.name#">code</a>)</cfif>
<cfelse>#lJustify("     directory", 33)# <a href="demo.cfm?demo=#demo##name#/">#name#/</a></cfif>

</cfoutput></pre>

</body>
</html>