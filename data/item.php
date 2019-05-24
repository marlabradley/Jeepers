<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Item</title>
</head>

<body>
<?php
    $part_num = $_REQUEST['partNumber'];
    $base = $_REQUEST['base'];
    $sub = $_REQUEST['sub'];

    $xml = new DOMDocument;
    $xml->load('sdc/Poison-Spyder-ACES.xml');

    // // Load XSL file
    $xsl = new DOMDocument;
    $xsl->load('item.xsl');

    // // Configure the transformer
    $proc = new XSLTProcessor();

    // // Attach the xsl rules
    $proc->importStyleSheet($xsl);

    // //Set parameter of the model name as to display only the parts for that model.
    $proc->setParameter('', 'PARTNUM', $part_num);
    $proc->setParameter('', 'BASEVID', $base);
    $proc->setParameter('', 'SUBMODELID', $sub);

    // //Transform
    echo $proc->transformToXML($xml);

?>
</body>

</html>