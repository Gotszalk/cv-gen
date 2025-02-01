<?xml version="1.0" encoding="UTF-8"?>

<xsl:transform version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:param name="filter" select="cv/default/filter" />
<xsl:param name="format" select="cv/default/format" />
<xsl:param name="country-display" select="cv/default/country-display" />
<xsl:param name="edu-display" select="cv/default/edu-display" />

<xsl:template match="/">
	<html>
		<head>
			<meta charset="UTF-8" />
			<link rel="stylesheet" href="style.css" />
			<title><xsl:value-of select="cv/name" /> Curriculum Vitae</title>
			<script>
				window.onload = function() {
					window.print()
				};
			</script>
		</head>
		<body>
			<div class="content">
			<div class="header"> <!-- top section -->
				<xsl:value-of select="cv/name" />
			</div>
			<xsl:apply-templates select="cv/intro[contains(context, $filter)]" />
			<!-- end of top section -->
			<div class="below"> 
				<div class="leftside"> <!-- left side of cv -->
					<xsl:apply-templates select="cv/sideinfo" />
				</div> <!-- end of left side -->
				<div class="rightside"> <!-- right side of cv -->
					<xsl:apply-templates select="cv/maininfo" />
					
				</div> <!-- end of right section -->
			
			</div>
			</div> <!--end of page content -->
			<div class="footer"><xsl:value-of select="/cv/footer" /></div>

		</body>
	</html>


</xsl:template>

<xsl:template match="intro">
	<div class="intro">
		<xsl:value-of select="description" />
	</div>
</xsl:template>

<xsl:template match="job">
	<div class="employment">
		<div class="entry"><xsl:value-of select="dates/from" /> - <xsl:value-of select="dates/to" />, <xsl:value-of select="company" /><xsl:if test="$country-display='yes'">, <xsl:value-of select="country" /></xsl:if></div>
			<!-- company link -->
			<div class="link">
				<xsl:element name="a">
					<xsl:attribute name="href">
					</xsl:attribute>
					<xsl:value-of select="url"/>
				</xsl:element>
			</div>
			<!-- end of company link -->
			<xsl:apply-templates select="position" />
		</div>
		<div class="separator">
		</div>
</xsl:template>

<xsl:template match="position">
	<div class="position"><xsl:value-of select="title" /></div>
	<xsl:apply-templates select="scope[contains(context, $filter)]|scope[contains(context, 'default')]" />
</xsl:template>

<xsl:template match="scope" >
	<div><p><xsl:value-of select="task" /></p></div>
</xsl:template>

<xsl:template match="sideinfo">
	<xsl:apply-templates select="personaldata" />
	<xsl:apply-templates select="skillpoints" />
	<xsl:apply-templates select="languages" />
</xsl:template>

<xsl:template match="personaldata">
	<div class="section"><xsl:value-of select="description" /></div>
	<xsl:apply-templates select="entry" />
</xsl:template>

<xsl:template match="entry">
	<div class="entry"><xsl:value-of select="category" /></div>
	<xsl:choose>
		<xsl:when test="type='link'" >
			<p>
			<xsl:element name="a">
				<xsl:attribute name="href">
					<xsl:choose>
						<xsl:when test="category='email'">
							<xsl:value-of select="concat('mailto:', value)" />
						</xsl:when>
						<xsl:when test="not(starts-with(value, 'http'))">
							<xsl:value-of select="concat('https://', value)" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="value" />
						</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<xsl:value-of select="value"/>
			</xsl:element>
			</p>
		</xsl:when>
		<xsl:when test="type='multiline'">
			<xsl:for-each select="value">
				<p><xsl:value-of select="line" /></p>
			</xsl:for-each>
		</xsl:when>
		<xsl:otherwise>
			<p><xsl:value-of select="value" /></p>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="skillpoints">
	<div class="section"><xsl:value-of select="description" /></div>
	<ul>
		<xsl:variable name="filterValue" select="$filter" />
		<xsl:apply-templates select="skill[contains(context, $filterValue)]" />
	</ul>
</xsl:template>

<xsl:template match="skill">
	<li><xsl:value-of select="name" /></li>
</xsl:template>

<xsl:template match="languages">
	<div class="section"><xsl:value-of select="description" /></div>
	<ul>
		<xsl:for-each select="language">
			<li><xsl:value-of select="lang" /> - <xsl:value-of select="level" /></li>
		</xsl:for-each>
	</ul>
</xsl:template>

<xsl:template match="maininfo">
	<xsl:apply-templates select="employment" />
	<xsl:if test="$edu-display='yes'" >
		<xsl:apply-templates select="education" />
	</xsl:if>
</xsl:template>

<xsl:template match="employment">
	<div class="section"><xsl:value-of select="description" /></div>
		<!-- short or not -->
		<xsl:choose>
			<xsl:when test="$format='short'" >
				<xsl:apply-templates select="job[@short='y']" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="job" />
			</xsl:otherwise>
		</xsl:choose>
				
</xsl:template>

<xsl:template match="education">
	<div class="section"><xsl:value-of select="description" /></div>
	<xsl:apply-templates select="school[contains(context, $filter)]" />

</xsl:template>

<xsl:template match="school">
	<div class="employment">
		<div class="entry"><xsl:value-of select="dates/from" /> - <xsl:value-of select="dates/to" />, <xsl:value-of select="name" /></div>
		
		<div class="position"><xsl:value-of select="profile"/></div>
		<div><p><xsl:value-of select="title" /></p></div>
		</div>
		<div class="separator">
		</div>
</xsl:template>

</xsl:transform>
