<cfset thisPath = getDirectoryFromPath(getCurrentTemplatePath()) />
<cfset oJS = CreateObject("component", "js").init() />
<cfset oJS.addScriptFromFile(thisPath & "browser.js") />
<cfset oJS.addScriptFromFile(thisPath & "less.js") />
<cfset oJS.addScriptFromFile(thisPath & "engine.js") />

<cffile action="read" file="#thisPath#../input.less" variable="inputLESS" />

<h2>Input LESS</h2>
<pre>
<cfoutput>#inputLESS#</cfoutput>
</pre>

<h2>Output CSS</h2>
<cfset outputCSS = oJS.compileString(inputLESS) />
<pre>
<cfoutput>#outputCSS#</cfoutput>
</pre>

<cfset oJS.exit() />