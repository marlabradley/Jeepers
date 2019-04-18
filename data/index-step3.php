<?php

$bvid = $_REQUEST['basevid'];
$token = $_REQUEST['token'];

//Display brand
$xml = new DOMDocument;
$xml->load('sdc/Poison-Spyder-ACES.xml');

// Load XSL file
$xsl = new DOMDocument;
$xsl->load('items.xsl');

// Configure the transformer
$proc = new XSLTProcessor();

// Attach the xsl rules
$proc->importStyleSheet($xsl);

//Set parameter of the model name as to display only the parts for that model.
$proc->setParameter('', 'BaseVehicleID1', $bvid);

//Transform
echo $proc->transformToXML($xml);

?>