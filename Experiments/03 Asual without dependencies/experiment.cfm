<cfscript>
	thisPath = getDirectoryFromPath(getCurrentTemplatePath());
    loadPaths = ArrayNew(1);
    arrayAppend(loadPaths, thisPath & "lesscss-engine-1.1.4.jar");
</cfscript>

<cfset loader = createObject("component", "javaloader.JavaLoader").init(loadPaths, 'true') />
<cfset engine = loader.create("com.asual.lesscss.LessEngine").init() />

<cffile action="read" file="#thisPath#../input.less" variable="inputLESS" />

<h2>Input LESS</h2>

<pre>
<cfoutput>#inputLESS#</cfoutput>
</pre>

<h2>Output CSS</h2>

<cfset outputCSS = engine.compile(inputLESS) />
<pre>
<cfoutput>#outputCSS#</cfoutput>
</pre>