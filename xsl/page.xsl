<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://www.w3.org/1999/xhtml">

<xsl:import href="fragment.xsl"/>

<xsl:output method="html"
	    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	    doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	    version="1.0"/>


<xsl:template match="page">
  <html>
    <head>
      <title><xsl:value-of select="@title"/>: <xsl:value-of select="@subtitle"/></title>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
      <link rel="stylesheet" type="text/css" href="../stylesheets/styles.css"/>
      <link rel="alternate stylesheet" title="Debug" type="text/css"
            href="../stylesheets/debug.css"/>
      <script type="text/javascript">
        <xsl:comment>jsvariable</xsl:comment>
      </script>
      <script type="text/javascript" src="../scripts/script.js"></script>
    </head>
    <body onload="initial_fold();">
      <div class="page">
        <div id="topbar">
          <table class="navbar">
            <tr>
              <td class="left">
                <xsl:if test="@prev">
                  <xsl:text>Prev: </xsl:text>
                  <a accesskey="p">
                    <xsl:attribute name="href"><xsl:value-of select="@prev"/></xsl:attribute>
                    <xsl:value-of select="@prevtitle"/>
                  </a>
                </xsl:if>
              </td>
              <td class="right">
                <xsl:if test="@next">
                  <xsl:text>Next: </xsl:text>
                  <a accesskey="n">
                    <xsl:attribute name="href"><xsl:value-of select="@next"/></xsl:attribute>
                    <xsl:value-of select="@nexttitle"/>
                  </a>
                </xsl:if>
              </td>
            </tr>
          </table>
          </div>
	<div class="titleblock">
	  <h1>easyJet A319/A320 FCOM (<xsl:value-of select="@version"/>)</h1>
     <h2><xsl:value-of select="@title"/></h2>
	</div>
   <xsl:comment>linkbar</xsl:comment>
	<xsl:if test="count(section) > 1">
	  <div class="pageindex">
	    <xsl:for-each select="section">
	      <p><a>
		<xsl:attribute name="href">
		  #sid<xsl:value-of select="@sid"/>
		</xsl:attribute>
		<xsl:value-of select="@sid"/>: <xsl:value-of select="@title"/>
	      </a></p>
	    </xsl:for-each>
	  </div>
	</xsl:if>
	  <xsl:apply-templates/>
     <div id="bottombar">
       <table class="navbar">
         <tr>
           <td class="left">
             <xsl:if test="@prev">
               <xsl:text>Prev: </xsl:text>
               <a>
                 <xsl:attribute name="href"><xsl:value-of select="@prev"/></xsl:attribute>
                 <xsl:value-of select="@prevtitle"/>
               </a>
             </xsl:if>
           </td>
           <td>
             <a href="#topbar">Top</a>
           </td>
           <td class="right">
             <xsl:if test="@next">
               <xsl:text>Next: </xsl:text>
               <a>
                 <xsl:attribute name="href"><xsl:value-of select="@next"/></xsl:attribute>
                 <xsl:value-of select="@nexttitle"/>
               </a>
             </xsl:if>
           </td>
         </tr>
       </table>
     </div>
      </div>
    </body>
  </html>
</xsl:template>


<xsl:template match="section">
  <div class="section">
    <xsl:attribute name="id">sid<xsl:value-of select="@sid"/></xsl:attribute>
    <h1 class="sectionheading"><xsl:value-of select="@sid"/>: <xsl:value-of select="@title"/></h1>
    <xsl:if test="count(du_container) &gt; 1">
      <div class="duindex">
	<xsl:for-each select="du_container">
	  <p><a>
       <xsl:attribute name="href">#duid<xsl:value-of select="@id"/></xsl:attribute>
       <xsl:value-of select="@title"/>
	  </a></p>
	</xsl:for-each>
      </div>
    </xsl:if>
    <xsl:apply-templates/>
  </div>
</xsl:template>


<xsl:template match="du_container">
  <div class="du_container">
    <xsl:attribute name="id">
      <xsl:text>duid</xsl:text><xsl:value-of select="@id"/>
    </xsl:attribute>
    <xsl:apply-templates/>
  </div>
</xsl:template>


<xsl:template match="du">
  <div>
    <xsl:choose>
      <xsl:when test="@tdu">
	<xsl:attribute name="class">main tdu</xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
	<xsl:attribute name="class">main</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>
	<xsl:attribute name="id">duid<xsl:value-of select="@id"/></xsl:attribute>
    <p class="duident">
      <a>
	<xsl:attribute name="href">../<xsl:value-of select="@href"/></xsl:attribute>
	<xsl:value-of select="@href"/>
      </a>
	<xsl:if test="applies">
	  <p class="applies"><a onclick="toggle_applies(this); return false;" href="#" alt="">
     <img src="../images/plus.gif" alt="" /></a>Applies to: <xsl:value-of select="applies"/></p>
	</xsl:if>
	<h1><xsl:value-of select="@title"/></h1>
    <xsl:choose>
      <xsl:when test="@href != ''">
        <xsl:apply-templates select="document(@href)"/>
      </xsl:when>
      <xsl:otherwise>
        <p>DU does not apply to selected aircraft.</p>
      </xsl:otherwise>
    </xsl:choose>
    </p>
  </div>
</xsl:template>

</xsl:stylesheet>
