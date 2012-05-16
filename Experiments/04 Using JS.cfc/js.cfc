<cfcomponent name="js" output="false" displayname="JavaScript in CF" hint="Run server-side JavaScript in Coldfusion">
	
	<cfset variables.context = "" />
	<cfset variables.scope = "" />

	<cffunction name="init" hint="initialise" output="true" access="public">

		<!--- create and enter the runtime context of the executing script --->
		<cfset variables.context = CreateObject("java", "org.mozilla.javascript.Context").init().enter() />
		<!--- maximum level of optimisation --->
		<cfset variables.context.setOptimizationLevel(9) />
		<!--- initialise standard objects (Object, Function) and get a scope object --->
		<cfset variables.scope = variables.context.initStandardObjects() />				

		<cfreturn this />
	</cffunction>
	
	<cffunction name="addScriptFromFile" hint="add in a JavaScript file" output="true" access="public">
		<cfargument name="path" required="true" type="string" hint="The absolute path to your template." />
		
		<cfset local.jsfile = CreateObject("java", "java.io.File").init(arguments.path) />
		<cfif local.jsfile.exists()>
			<cfset local.stream = CreateObject("java", "java.io.FileInputStream").init(local.jsfile)>
			<cfset local.streamer = CreateObject("java", "java.io.InputStreamReader").init(local.stream) />
			<cfset variables.context.evaluateReader(variables.scope, local.streamer, local.jsfile.getName(), 1, JavaCast('null', '') ) />
		<cfelse>
			<cfthrow message="The JavaScript file you specified does not exist." />
		</cfif>
	
		<cfreturn />
	</cffunction>
	
	<cffunction name="addScriptFromUrl" hint="add in JavaScript from a URL" output="true" access="public">
		<cfargument name="href" required="true" type="string" hint="The URL to retrieve." />
	
		<cfset local.jsfile = CreateObject("java", "java.net.URL").init(arguments.href) />
		<cfset local.streamer = CreateObject("java", "java.io.InputStreamReader").init(local.jsfile.openConnection().getInputStream()) />
		<cfset variables.context.evaluateReader(variables.scope, local.streamer, local.jsfile.getFile(), 1, JavaCast('null', '') ) />
	
		<cfreturn />
	</cffunction>
	
	<cffunction name="addScript" hint="add in JavaScript from a string" output="true" access="public">
		<cfargument name="code" required="true" type="string" hint="JavaScript code." />
	
		<cfset variables.context.evaluateString(variables.scope, arguments.code, "inlineScript", 1, JavaCast('null', '') ) />
	
		<cfreturn />
	</cffunction>
	
	<cffunction name="callJsFunction" output="false" access="public" hint="Call a JavaScript function">
		<cfargument name="fname" type="string" required="true" hint="JavaScript function name" />
		<cfargument name="args" type="array" required="false" default="#JavaCast('null', '')#" hint="Array of JavaScript arguments to pass to the function" />
	
		<cfset local.compiledFn = CreateObject('java', "org.mozilla.javascript.Function").getClass().cast(variables.scope.get(arguments.fname, variables.scope)) />
		
		<cfreturn variables.context.call(JavaCast('null', ''), local.compiledFn, scope, scope, arguments.args) />
	</cffunction>


	<!--- Let's see if we can be clever and use OnMissingMethod to make the syntax more JavaScript-y --->
    <cffunction name="onMissingMethod" access="public" returntype="any" output="false" hint="Handles missing method exceptions.">
   		<cfargument name="missingMethodName" type="string" required="true" hint="The name of the missing method." />
    	<cfargument name="missingMethodArguments" type="struct" required="true" hint="The arguments that were passed." />
      
		<!--- convert the method arguments from a structure to the array that Java needs - quick and dirty method --->
		<cfset local.args = [] />

		<cfloop from="1" to="#StructCount(arguments.missingMethodArguments)#" index="local.i">
			<cfset local.args[local.i] = arguments.missingMethodArguments[local.i] />
		</cfloop>

	     <cfreturn this.callJsFunction(arguments.missingMethodName, local.args) />
     </cffunction>	

	<cffunction name="exit" hint="Cleanup - exit context" output="false" access="public">
		<cfset variables.context.exit() />
	</cffunction>

</cfcomponent>