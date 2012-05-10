<cfscript>

	param sourcefile=getFileFromPath(cgi.cf_template_path);
	demoPath = getDirectoryFromPath(sourcefile);
	codeToShow = fileRead(expandPath(sourcefile));
	codeToShow = htmlCodeFormat(codeToShow);

</cfscript>

<cfcontent reset="true"><!doctype html>
<html lang="en">
<head>
	<link rel="stylesheet/less" type="text/css" href="../demo.less" />
	<script src="../less-1.3.0.min.js"></script>

	<link rel="stylesheet" type="text/css" href="../google-code-prettify/prettify.css" />
	<script type="text/javascript" src="../google-code-prettify/prettify.js"></script>
</head>
<body>
<cfoutput>
	<nav>
		<a href="./">&laquo; workflows</a>
		<a href="browse.cfm?demo=#demoPath#">&##x25b2; directory</a>
	</nav>
	<h1>LESS CSS, Meet ColdFusion: Code: #sourcefile#</h1>
	#codeToShow#
</cfoutput>
<script>
	pre = document.getElementsByTagName("pre");
	for(var i in pre) {
		pre[i].className="prettyprint";
	}
	prettyPrint();</script>
</body>
</html>