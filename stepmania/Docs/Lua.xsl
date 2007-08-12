<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sm="http://www.stepmania.com"
	exclude-result-prefixes="sm">
<!-- This could be xhtml 1.0 strict, but firefox is failing at displaying the
     resultant document even though it seems to parse it just fine. -->
<xsl:output method="html"
	version="4.01"
	encoding="UTF-8"
	doctype-system="http://www.w3.org/TR/html4/strict.dtd"
	doctype-public="-//W3C//DTD HTML 4.01//EN"
	indent="no"
	media-type="text/html" />
<!--
<xsl:output method="xml"
	version="1.0"
	encoding="UTF-8"
	doctype-system="http://www.w3.org/TR/2000/REC-xhtml1-20000126/DTD/xhtml1-strict.dtd"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	media-type="application/xhtml+xml" />
-->
<xsl:template match="/">
<xsl:comment>This file is automatically generated. Do not edit it.</xsl:comment>
	<html>
		<head>
			<title>StepMania LUA Information</title>
			<style type="text/css">
			th {
				background-color: #CCCCFF;
				border-style: solid;
				border-width: thin;
				padding: 2px;
				font-size: 150%
			}
			table {
				border-style: ridge;
				border-collapse: collapse
			}
			td {
				padding: 2px;
				border-style: solid;
				border-width: thin
			}
			hr {
				width: 90%
			}
			code {
				font-family: monospace
			}
			.code {
				font-family: monospace
			}
			.returnTypeCell {
				font-family: monospace;
				text-align: right;
				vertical-align: text-top;
				width: 10em
			}
			.descriptionCell {
				text-align: justify;
				vertical-align: text-top
			}
			.descriptionName {
				font-family: monospace;
				font-weight: bold
			}
			.descriptionArguments {
				font-family: monospace
			}
			.descriptionText {
				text-indent: 2em;
				margin-top: 0;
				margin-bottom: 0
			}
			.primitiveType {
				font-family: monospace;
				color: #0000ff
			}
			a.classType:link {
				font-family: monospace;
				color: #cc0000
			}
			a.classType:visited {
				font-family: monospace;
				color: #440000
			}
			a.enumType:link {
				font-family: monospace;
				color: #cc0000
			}
			a.enumType:visited {
				font-family: monospace;
				color: #440000
			}
			.trigger {
				cursor: pointer
			}
			.footer {
				text-align: center
			}
			</style>
			<script type="text/javascript">
			function Open( id )
			{
				var imgid = 'img_' + id;
				var listid = 'list_' + id;
				var img = document.getElementById( imgid );
				var list = document.getElementById( listid );
			
				img.setAttribute( 'src', 'open.gif' );
				list.style.display = 'block';
			}
			function OpenAndMove( classid, functionid )
			{
				Open( classid );
				location.hash = classid + '_' + functionid;
			}
			function Toggle( id )
			{
				var imgid = 'img_' + id;
				var listid = 'list_' + id;
				var img = document.getElementById( imgid );
				var list = document.getElementById( listid );
				
				if( img.getAttribute('src') == 'closed.gif' )
				{
					img.setAttribute( 'src', 'open.gif' );
					list.style.display = 'block';
				}
				else
				{
					img.setAttribute( 'src', 'closed.gif' );
					list.style.display = 'none';
				}
			}
			</script>
		</head>
		<body>
			<xsl:apply-templates />
		</body>
	</html>
</xsl:template>


<xsl:template match="sm:Lua">
	<div>
		<h2>StepMania LUA Information</h2>
		<table>
			<tr>
				<th><a href="#Singletons">Singletons</a></th>
				<th><a href="#Classes">Classes</a></th>
				<th><a href="#GlobalFunctions">Global Functions</a></th>
				<th><a href="#Enums">Enums</a></th>
				<th><a href="#Constants">Constants</a></th>
			</tr>
		</table>
	</div>
	<xsl:apply-templates select="sm:Singletons" />
	<xsl:apply-templates select="sm:Classes" />
	<xsl:apply-templates select="sm:GlobalFunctions" />
	<xsl:apply-templates select="sm:Enums" />
	<xsl:apply-templates select="sm:Constants" />
	<hr />
	<p class="footer">
		Generated for <xsl:value-of select="sm:Version" /> on
		<xsl:value-of select="sm:Date" />.
	</p>
</xsl:template>


<xsl:template match="sm:Singletons">
	<div>
		<h3 id="Singletons">Singletons</h3>
		<ul>
			<xsl:for-each select="sm:Singleton">
				<xsl:sort select="@name" />
				<li>
					<a class="classType" href="#{@class}" onclick="Open('{@class}')">
						<xsl:value-of select="@name" />
					</a>
				</li>
			</xsl:for-each>
		</ul>
	</div>
</xsl:template>


<xsl:template match="sm:Classes">
	<div>
		<h3 id="Classes">Classes</h3>
		<xsl:apply-templates select="sm:Class">
			<xsl:sort select="@name" />
		</xsl:apply-templates>
	</div>
</xsl:template>

<xsl:variable name="docs" select="document('LuaDocumentation.xml')/sm:Documentation" />

<xsl:template match="sm:Class">
	<xsl:variable name="name" select="@name" />
	<div>
		<a id="{@name}" class="trigger" onclick="Toggle('{@name}')">
			<img src="closed.gif" id="img_{@name}" alt="" />
			Class <span class="descriptionName"><xsl:value-of select="@name" /></span>
		</a>
		<xsl:if test="@base != ''">
			<span class="code"><xsl:text> : </xsl:text></span>
			<a class="classType" href="#{@base}" onclick="Open('{@base}')">
				<xsl:value-of select="@base" />
			</a>
		</xsl:if>
		<div style="display: none" id="list_{@name}">
		<xsl:apply-templates select="$docs/sm:Classes/sm:Class[@name=$name]/sm:Description" />
		<table>
			<tr><th colspan="2"><xsl:value-of select="$name" /> Member Functions</th></tr>
			<xsl:apply-templates select="sm:Function">
				<xsl:sort select="@name" />
				<xsl:with-param name="path" select="$docs/sm:Classes/sm:Class[@name=$name]" />
				<xsl:with-param name="class" select="$name" />
			</xsl:apply-templates>
		</table>
		<br />
		</div>
	</div>
</xsl:template>


<xsl:template match="sm:GlobalFunctions">
	<div>
		<h3 id="GlobalFunctions">Global Functions</h3>
		<table>
			<tr><th colspan="2">Functions</th></tr>
			<xsl:apply-templates select="sm:Function">
				<xsl:sort select="@name" />
				<xsl:with-param name="path" select="$docs/sm:GlobalFunctions" />
				<xsl:with-param name="class" select="'GLOBAL'" />
			</xsl:apply-templates>
		</table>
	</div>
</xsl:template>

<xsl:template name="processType">
	<xsl:param name="type" />
	<xsl:choose>
		<xsl:when test="$type='void' or
				$type='int' or
				$type='float' or
				$type='string' or
				$type='bool'">
			<span class="primitiveType">
				<xsl:value-of select="$type" />
			</span>
		</xsl:when>
		<xsl:when test="boolean(/sm:Lua/sm:Classes/sm:Class[@name=$type])">
			<a class="classType" href="#{$type}" onclick="Open('{$type}')">
				<xsl:value-of select="$type" />
			</a>
		</xsl:when>
		<xsl:when test="boolean(/sm:Lua/sm:Enums/sm:Enum[@name=$type])">
			<a class="enumType" href="#ENUM_{$type}" onclick="Open('{$type}')">
				<xsl:value-of select="$type" />
			</a>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$type" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="processArguments">
	<xsl:param name="argumentList" />
	<xsl:choose>
		<!-- Base case. -->
		<xsl:when test="not(contains($argumentList, ','))">
			<xsl:call-template name="processType">
				<xsl:with-param name="type"
				                select="substring-before($argumentList, ' ')" />
			</xsl:call-template>
			<xsl:text> </xsl:text>
			<xsl:value-of select="substring-after($argumentList, ' ')" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:variable name="before"
				      select="substring-before($argumentList, ',')" />
			<xsl:variable name="after"
			              select="substring-after($argumentList, ',')" />
			<xsl:call-template name="processType">
				<xsl:with-param name="type"
						select="substring-before($before, ' ')" />
			</xsl:call-template>
			<xsl:value-of select="substring-after($before, ',')" /><xsl:text>, </xsl:text>
			<!-- Recursive call. -->
			<xsl:call-template name="processArguments">
				<xsl:with-param name="argumentList" select="$after" />
			</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="sm:Function">
	<xsl:param name="path" />
	<xsl:param name="class" />
	<xsl:variable name="name" select="@name" />
	<xsl:variable name="elmt" select="$path/sm:Function[@name=$name]" />
	<tr id="{$class}_{$name}">
	<xsl:choose>
		<!-- Check for documentation. -->
		<xsl:when test="string($elmt/@name)=$name">
			<td class="returnTypeCell">
			<xsl:call-template name="processType">
				<xsl:with-param name="type" select="$elmt/@return" />
			</xsl:call-template>
			</td>
			<td class="descriptionCell">
			<span class="descriptionName">
				<xsl:value-of select="@name" />
			</span>
			<span class="descriptionArguments">(
				<xsl:call-template name="processArguments">
					<xsl:with-param name="argumentList"
					                select="$elmt/@arguments" />
				</xsl:call-template>
				)</span>
			<p class="descriptionText">
				<xsl:apply-templates select="$elmt" mode="print">
					<xsl:with-param name="class" select="$class" />
				</xsl:apply-templates>
			</p>
			</td>
		</xsl:when>
		<xsl:otherwise>
			<td class="returnTypeCell" />
			<td class="descriptionCell">
				<span class="descriptionName"><xsl:value-of select="@name" /></span>
			</td>
		</xsl:otherwise>
	</xsl:choose>
	</tr>
</xsl:template>
<xsl:template match="sm:Function" mode="print">
	<xsl:param name="class" />
	<xsl:apply-templates>
		<xsl:with-param name="curclass" select="$class" />
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="sm:Link">
	<xsl:param name="curclass" />
	<xsl:choose>
		<xsl:when test="string(@class)='' and string(@function)!=''">
			<a class="classType" href="#{$curclass}_{@function}"><xsl:apply-templates /></a>
		</xsl:when>
		<xsl:when test="string(@class)!='' and string(@function)=''">
			<a class="classType" href="#{@class}" onclick="Open('{@class}')"><xsl:apply-templates /></a>
		</xsl:when>
		<xsl:when test="(string(@class)='GLOBAL' or string(@class)='ENUM') and string(@function)!=''">
			<a class="classType" href="#{@class}_{@function}" onclick="Open('{@function}')"><xsl:apply-templates /></a>
		</xsl:when>
		<xsl:when test="string(@class)!='' and string(@function)!=''">
			<a class="classType" href="#{@class}_{@function}" onclick="OpenAndMove('{@class}','{@function}')"><xsl:apply-templates /></a>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates /> <!-- Ignore this Link. -->
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="sm:Enums">
	<div>
		<h3 id="Enums">Enums</h3>
		<xsl:apply-templates select="sm:Enum">
			<xsl:sort select="@name" />
		</xsl:apply-templates>
	</div>
</xsl:template>


<xsl:template match="sm:Enum">
	<xsl:variable name="name" select="@name" />
	<div id="ENUM_{@name}">
		<a class="trigger" onclick="Toggle('{@name}')">
		<img src="closed.gif" id="img_{@name}" alt="" />
		Enum <span class="descriptionName"><xsl:value-of select="@name" /></span></a>
		<div style="display: none" id="list_{@name}">
		<xsl:apply-templates select="$docs/sm:Enums/sm:Enum[@name=$name]/sm:Description" />
		<table>
			<tr>
				<th>Enum</th>
				<th>Value</th>
			</tr>
			<xsl:for-each select="sm:EnumValue">
				<xsl:sort data-type="number" select="@value" />
				<tr class="code">
					<td><xsl:value-of select="@name" /></td>
					<td><xsl:value-of select="@value" /></td>
				</tr>
			</xsl:for-each>
		</table>
		<br />
		</div>
	</div>
</xsl:template>

<xsl:template match="sm:Description">
	<p><xsl:apply-templates /></p>
</xsl:template>

<xsl:template match="sm:Constants">
	<div>
		<h3 id="Constants">Constants</h3>
		<table>
			<tr>
				<th>Constant</th>
				<th>Value</th>
			</tr>
			<xsl:for-each select="sm:Constant">
				<xsl:sort select="@name" />
				<tr class="code">
					<td><xsl:value-of select="@name" /></td>
					<td><xsl:value-of select="@value" /></td>
				</tr>
			</xsl:for-each>
		</table>
		<br />
	</div>
</xsl:template>

<!-- XXX: This is annoying, how can we tell xsl to just pass the html through? -->
<xsl:template match="sm:code"><code><xsl:apply-templates /></code></xsl:template>
<xsl:template match="sm:br"><br /></xsl:template>
</xsl:stylesheet>
