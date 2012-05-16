<cfscript>

	param demo=getFileFromPath(cgi.cf_template_path);
	demoPath = getDirectoryFromPath(demo);
	parentPath = reverse(listRest(reverse(demoPath), "/")) & "/";

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
		<a href="./">&laquo; experiments</a> <a href="browse.cfm?demo=#demoPath#">&##x25b2; directory</a>
	</nav>
	<h1>Running #reReplace(listLast(demo, "/"), "^\d+\s*", "")#</h1>
	<cfinclude template="#demo#" />
</cfoutput>
<script>
	pre = document.getElementsByTagName("pre");
	for(var i in pre) {
		pre[i].className="prettyprint";
	}
	prettyPrint();</script>
</body>
</html>