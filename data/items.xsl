<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:ac="http://www.autocare.org">

<xsl:output method="html" indent="yes"/>

<xsl:template match="/">
<html>
    <head>
        <title>Jeep Parts for Sale</title>
        <style type="text/css">
        body {
            margin:10px;
            background-color:#ffffff;
            font-family:verdana,helvetica,sans-serif;
        }

        .pies-bold-text {
            display:block;
            font-weight:bold;
        }

        .pies-text {
            display:block;
            color:#000000;
            font-size:14;
        }
        table, th, td {
          padding: 15px;
        }
        td {
          border: 1px solid black;
        }
        .td-spacing {
          border: 0px solid black;
          padding: 8px;
        }
        </style>
    </head>
    <body>
          <xsl:apply-templates/>
    </body>
</html>
</xsl:template>

<xsl:template match="ac:Header">
    <span class="pies-bold-text">All items are sold from Jeepers Inc.</span>
    <xsl:element name="br"/>
</xsl:template>

<xsl:template match="ac:PriceSheets">
    <xsl:for-each select="ac:PriceSheet">
    </xsl:for-each>
</xsl:template>

<xsl:template match="ac:MarketingCopy">
    <xsl:for-each select="ac:MarketCopy">
    </xsl:for-each>
</xsl:template>


<xsl:template match="ac:Items">
<xsl:element name="table"><xsl:attribute name="width">100%</xsl:attribute><xsl:attribute name="align">center</xsl:attribute>
    <xsl:element name="tr">
    <xsl:for-each select="ac:Item">
       <xsl:element name="td"><xsl:attribute name="align">center</xsl:attribute><xsl:attribute name="valign">bottom</xsl:attribute>
          <xsl:for-each select="ac:DigitalAssets">
             <xsl:for-each select="ac:DigitalFileInformation">
                <xsl:if test="(ac:FileType = 'PNG')">
                   <xsl:element name="IMG">
                      <xsl:attribute name="src">sdc/Poison-Spyder-Digital-Assets-PIES/<xsl:value-of select="ac:FileName"/></xsl:attribute>
                      <xsl:attribute name="title"><xsl:for-each select="ac:AssetDescriptions"><xsl:value-of select="ac:Description"/></xsl:for-each></xsl:attribute >
                      <xsl:attribute name="width">225</xsl:attribute>
                  </xsl:element>
                </xsl:if>
             </xsl:for-each>
          </xsl:for-each>
          <xsl:element name="br"/>

          <xsl:for-each select="ac:Prices"><xsl:for-each select="ac:Pricing">
             <xsl:if test="(@PriceType = 'LST')">
                $<xsl:variable name="number"><xsl:value-of select="ac:Price"/></xsl:variable>
                <xsl:value-of select="format-number($number,'#.##')"/>
             </xsl:if>
          </xsl:for-each></xsl:for-each>

          <xsl:element name="br"/><xsl:element name="br"/>
          <span class="pies-text"><xsl:value-of select="ac:PartNumber"/></span>
          <xsl:element name="br"/>
          <xsl:for-each select="ac:Descriptions"><xsl:for-each select="ac:Description"><xsl:if test="(@DescriptionCode = 'DES')"><xsl:value-of select="."/></xsl:if></xsl:for-each></xsl:for-each>
       </xsl:element>
       <xsl:choose><xsl:when test="position() div '4' = round(position() div '4')">
          <xsl:element name="tr"><xsl:element name="td"><xsl:attribute name="class">td-spacing</xsl:attribute>
	  </xsl:element></xsl:element>
       </xsl:when></xsl:choose> 

   </xsl:for-each>
   </xsl:element>
</xsl:element>
</xsl:template>


<xsl:template match="ac:Trailer">
       <span class="pies-bold-text"><xsl:element name="br"/>Item Count:<xsl:value-of select="ac:ItemCount"/></span>
       <span class="pies-text"><xsl:value-of select="ac:TransactionDate"/></span>
       <xsl:element name="br"/>
</xsl:template>

</xsl:stylesheet>