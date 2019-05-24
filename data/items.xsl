<?xml version="1.0" encoding="utf-8"?>
<!-- Might be able to use this for the 4 column loop https://stackoverflow.com/questions/2802159/how-to-use-for-loop-in-xslt -->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:pi="http://www.autocare.org">
    <xsl:output method="html" indent="yes"/>
    <xsl:param name="BASEVID" select="default" />
    <xsl:param name="SUBMODELID" select="default" />
    <!-- <xsl:param name="CATEGORY" select="default" /> -->
    <xsl:template match="/">
        <table>
            <tr>
                <th>Photo</th>
            </tr>
            <xsl:apply-templates select="ACES/App[(BaseVehicle/@id = $BASEVID) and (SubModel/@id = $SUBMODELID) and (Region/@id = 2)]" />
        </table>
</xsl:template>
<!-- <xsl:template match="Header"><span class="pies-bold-text">All items are sold from Jeepers Inc.</span><xsl:element name="br"/></xsl:template> -->
<xsl:template match="App">
    <xsl:element name="tr">
        <!-- CATEGORY: <xsl:value-of select="$CATEGORY" /> -->
        <xsl:variable name="PARTNUM" select="Part" />
        <xsl:for-each select="document('sdc/Poison-Spyder-PIES.xml')/pi:PIES/pi:Items/pi:Item[pi:PartNumber=$PARTNUM]">
            <xsl:element name="td">
                <xsl:element name="a">
                    <xsl:attribute name="target">_blank</xsl:attribute>
                    <xsl:attribute name="href">/data/item.php?partNumber=<xsl:value-of select="pi:PartNumber"/>&amp;base=<xsl:value-of select="$BASEVID"/>&amp;sub=<xsl:value-of select="$SUBMODELID"/>
                    </xsl:attribute>
                    <xsl:element name="div">
                        <xsl:attribute name="class">image</xsl:attribute>
                        <xsl:for-each select="pi:DigitalAssets">
                            <xsl:for-each select="pi:DigitalFileInformation[pi:FileType]">
                                <xsl:variable name="ps222" select="preceding-sibling::*" />
                                <xsl:if test="not($ps222/pi:FileType = 'JPG') and not(pi:URI = 'https://tmg.imagerelay.com/share/f9e3c9a5d5f646f19751bfb7c21f0e0c')">
                                    <xsl:choose>
                                        <xsl:when test="pi:URI">
                                            <xsl:element name="IMG">
                                                <xsl:attribute name="src">
                                                    <xsl:value-of select="pi:URI"/>
                                                </xsl:attribute>
                                                <xsl:attribute name="width">225</xsl:attribute>
                                            </xsl:element>
                                        </xsl:when>
                                    </xsl:choose>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:for-each>
                    </xsl:element>
                    <xsl:element name="div">
                        <xsl:element name="div">
                            <xsl:text>Part Number: </xsl:text>
                            <xsl:value-of select="pi:PartNumber"/>
                        </xsl:element>
                        <xsl:element name="div">
                            <xsl:for-each select="pi:Prices">
                                <xsl:for-each select="pi:Pricing">
                                    <xsl:if test="(@PriceType = 'LST')">
                                        <xsl:text>$</xsl:text>
                                        <xsl:variable name="number">
                                            <xsl:value-of select="pi:Price"/>
                                        </xsl:variable>
                                        <xsl:value-of select="format-number($number,'#.##')"/>
                                    </xsl:if>
                                </xsl:for-each>
                            </xsl:for-each>
                        </xsl:element>
                    </xsl:element>
                    <xsl:element name="div">
                        <xsl:text>Desc:</xsl:text>
                        <xsl:for-each select="pi:Descriptions">
                            <xsl:for-each select="pi:Description">
                                <xsl:if test="(@DescriptionCode = 'DES')">
                                    <xsl:value-of select="."/>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
        </xsl:for-each>
    </xsl:element>
</xsl:template>
<xsl:template match="Footer">
    <xsl:element name="br"/>
</xsl:template>
<!-- <xsl:template match="pi:Item"><xsl:element name="td"><xsl:attribute name="align">center</xsl:attribute><xsl:attribute name="valign">bottom</xsl:attribute><xsl:for-each select="pi:DigitalAssets"><xsl:for-each select="pi:DigitalFileInformation"><xsl:if test="(pi:FileType = 'PNG')"><xsl:element name="IMG"><xsl:attribute name="src">sdc/Poison-Spyder-Digital-Assets-PIES/

                                <xsl:value-of select="pi:FileName"/></xsl:attribute><xsl:attribute name="title"><xsl:for-each select="pi:AssetDescriptions"><xsl:value-of select="pi:Description"/></xsl:for-each></xsl:attribute ><xsl:attribute name="width">225</xsl:attribute></xsl:element></xsl:if></xsl:for-each></xsl:for-each><xsl:element name="br"/><xsl:for-each select="pi:Prices"><xsl:for-each select="pi:Pricing"><xsl:if test="(@PriceType = 'LST')">
                        $<xsl:variable name="number"><xsl:value-of select="pi:Price"/></xsl:variable><xsl:value-of select="format-number($number,'#.##')"/></xsl:if></xsl:for-each></xsl:for-each><xsl:element name="br"/><xsl:element name="br"/><span class="pies-text"><xsl:value-of select="pi:PartNumber"/></span><xsl:for-each select="pi:Descriptions"><xsl:for-each select="pi:Description"><xsl:if test="(@DescriptionCode = 'DES')"><xsl:value-of select="."/></xsl:if></xsl:for-each></xsl:for-each></xsl:element></xsl:template> -->
</xsl:stylesheet>