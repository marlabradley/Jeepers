<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Jeep Parts for Sale</title>
    <style type="text/css">
        body {
            margin: 10px;
            background-color: #ffffff;
            font-family: verdana, helvetica, sans-serif;
        }
        a {
            all:unset;
        }
        .pies-bold-text {
            display: block;
            font-weight: bold;
        }

        .pies-text {
            display: block;
            color: #000000;
            font-size: 14;
        }

        table,
        th,
        td {
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
    <?php
    // Global Vairables
    $year_request = $_REQUEST['year'];
    $token_request = $_REQUEST['token'];
    $bvid_request = $_REQUEST['basevid'];
    $bvid_arrary_request = explode("-", $bvid_request);
    $model_request = $bvid_arrary_request[0];
    $basevehicleid_request = $bvid_arrary_request[1];
    $submodel_request = $_REQUEST['Submodel'];
    $sub_arrary_request = explode("-", $submodel_request);
    $basevehicleid_request_final = $_REQUEST['BaseVehicleID2'];


    if ($submodel_request == null){

        //GET SDC TOKEN
        $tokenurl='https://sdc.semadatacoop.org/sdcapi/token/get?userName=MBradley&password=MBradleySDC!';
        $tokenurlcontents = file_get_contents($tokenurl);
        $token_json = json_decode($tokenurlcontents, true);
        $token = $token_json['token'];
        //echo $token . "<br/>";

        //GET LIST OF YEARS AVAILABLE
        $yearsurl = "https://sdc.semadatacoop.org/sdcapi/lookup/years?token=" . $token;
        $yearscontents = file_get_contents($yearsurl);
        $years_json = json_decode($yearscontents, true);
        $years_arr = $years_json['Years'];
        echo "<form action=\"index.php\" method=\"post\">" .
            "<input type=\"hidden\" name=\"token\" value=\"" . $token . "\"> " . 
            "Select Year: " . 
            "<select name=\"year\" onchange=\"this.form.submit()\">" .
            "<option value=\"select a year\">Select a Year</option>";
        foreach ($years_arr as $v)
        { 
            echo "<option value=\"" . 
            $v .
            "\">" . $v . 
            "</option>";
        }
        echo " </select>";
        echo "</form>";

        //GET LIST OF MODELS
        if (!$year_request == null){
            
            $modelsurl = "https://sdc.semadatacoop.org/sdcapi/lookup/models?token=" . $token_request .
            "&year=" . $year_request . "&makeid=42";
            $modelscontents = file_get_contents($modelsurl);
            $models_json = json_decode($modelscontents, true);
            $models_arry = $models_json['Models'];
            echo "<br/><form action=\"index.php\" method=\"post\">" .
            "<input type=\"hidden\" name=\"token\" value=\"" . $token_request . "\"> " . 
            "<input type=\"hidden\" name=\"year\" value=\"" . $year_request . "\"> " .
            "Select Model: " . 
            "<select name=\"basevid\" onchange=\"this.form.submit()\">" .
            "<option value=\"select a model\">Select a Model</option>";
            foreach ($models_arry as $v)
            {  
            echo "<option value=\"" . $v["ModelID"] . "-" . $v["BaseVehicleID"] .
            "\">" . $v["ModelName"] . " " . $v["ModelID"] . " " . $v["BaseVehicleID"] . 
            "</option>";
            }
            echo " </select> ";
            echo "</form>";
            $acessurl = "https://sdc.semadatacoop.org/sdcapi/lookup/expandedvehicleinfo?token=" . $token_request .
            $acescontents = file_get_contents($acessurl);
            $aces_json = json_decode($acescontents, true);
            $aces_vehicle_arry = $models_json['Vehicles'];
        }

        //GET LIST OF SUB-MODELS
        if (!$model_request == null){
            
            $submodelsurl = "https://sdc.semadatacoop.org/sdcapi/lookup/submodels?token=" . $token_request .
                "&year=" . $year_request . "&makeid=42&modelid=" . $model_request;
            $submodelscontents = file_get_contents($submodelsurl);
            $submodels_json = json_decode($submodelscontents, true);
            $submodels_arry = $submodels_json['Submodels'];
            echo "<br/><form action=\"index.php\" method=\"post\">" .
                "<input type=\"hidden\" name=\"token\" value=\"" . $token_request . "\"> " .
                "<input type=\"hidden\" name=\"year\" value=\"" . $year_request . "\"> " .
                "<input type=\"hidden\" name=\"BaseVehicleID2\" value=\"" . $basevehicleid_request . "\"> " .
                "Select Submodel: " . 
                "<select name=\"Submodel\" onchange=\"this.form.submit()\">" .
                "<option value=\"select a submodel\">Select a Sub-Model</option>";
            foreach ($submodels_arry as $vsub)
            {  
                echo "<option value=\"" . $vsub["VehicleID"] . "-" . $vsub["SubmodelID"] . "-" . $vsub["SubmodelName"] .
                "\">" . $vsub["VehicleID"] . " " . $vsub["SubmodelID"] . " " . $vsub["SubmodelName"] . 
                "</option>";
            }
            echo " </select></form>";
        }
    } else {
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
        $proc->setParameter('', 'BASEVID', $basevehicleid_request_final);
        $proc->setParameter('', 'SUBMODELID', $sub_arrary_request[1]);

        //Transform
        echo $proc->transformToXML($xml);
    }

?>
</body>

</html>