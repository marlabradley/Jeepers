<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:ac="http://www.autocare.org">

<xsl:output method="html" indent="yes"/>
<xsl:param name="BaseVehicleID1" select="default" />

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
        BaseVehicleID: <xsl:value-of select="$BaseVehicleID1" />
                <xsl:apply-templates/>
    </body>
</html>
</xsl:template>

<xsl:template match="Header">
    <span class="pies-bold-text">All items are sold from Jeepers Inc.</span>
    <xsl:element name="br"/>
</xsl:template>

<xsl:template match="App">
    <xsl:if test="(BaseVehicle/@id = $BaseVehicleID1)">
        <xsl:variable name="PARTNUM" select="Part" />  
        <xsl:for-each select="document('sdc/Poison-Spyder-PIES.xml')/ac:PIES/ac:Items/ac:Item">
            <xsl:if test="ac:PartNumber=$PARTNUM">
                    <xsl:for-each select="ac:DigitalAssets">
                    <xsl:for-each select="ac:DigitalFileInformation">
                        <xsl:element name="br"/><xsl:element name="br"/><xsl:value-of select="ac:FileName"/>
                        <xsl:choose>
                            <xsl:when test="(ac:FileType = 'PNG')">
                                <xsl:element name="IMG"><xsl:attribute name="src">https://www.jeepersinc.com/data/sdc/Poison-Spyder-Digital-Assets-PIES/<xsl:value-of select="ac:FileName"/></xsl:attribute><xsl:attribute name="title"><xsl:for-each select="ac:AssetDescriptions"><xsl:value-of select="ac:Description"/></xsl:for-each></xsl:attribute ><xsl:attribute name="width">225</xsl:attribute></xsl:element><xsl:element name="br"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:choose>
                                    <xsl:when test="(ac:FileType = 'JPG')">
                                        <xsl:element name="IMG"><xsl:attribute name="src">https://www.jeepersinc.com/data/sdc/Poison-Spyder-Digital-Assets-PIES/<xsl:value-of select="ac:FileName"/></xsl:attribute><xsl:attribute name="title"><xsl:for-each select="ac:AssetDescriptions"><xsl:value-of select="ac:Description"/></xsl:for-each></xsl:attribute ><xsl:attribute name="width">225</xsl:attribute></xsl:element><xsl:element name="br"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        NO PICTURE<xsl:element name="br"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:otherwise>
                        </xsl:choose>
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
                    <xsl:for-each select="ac:Descriptions"><xsl:for-each select="ac:Description"><xsl:if test="(@DescriptionCode = 'DES')"><xsl:value-of select="."/></xsl:if></xsl:for-each></xsl:for-each>
            </xsl:if>
        </xsl:for-each>
    </xsl:if>
</xsl:template>

<xsl:template match="Footer">
    <span class="pies-bold-text">Footer</span>
    <xsl:element name="br"/>
</xsl:template>

<xsl:template match="ac:Item">
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
       <xsl:for-each select="ac:Descriptions"><xsl:for-each select="ac:Description"><xsl:if test="(@DescriptionCode = 'DES')"><xsl:value-of select="."/></xsl:if></xsl:for-each></xsl:for-each>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>