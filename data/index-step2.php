<?php

//GET LIST OF MAKES AVAILABLE - Jeep is 42
$year = $_REQUEST['year'];
$token = $_REQUEST['token'];

//GET LIST OF YEARS AVAILABLE
$yearsurl = "https://sdc.semadatacoop.org/sdcapi/lookup/years?token=" . $token;
$yearscontents = file_get_contents($yearsurl);
$years1 = json_decode($yearscontents, true);
//echo "<br/><br/>Years:"; print_r($years1); print_r($years1["Years"]); echo $years1["Years"][0];
echo "<form action=\"index-step2.php\" method=\"post\">" .
     "<input type=\"hidden\" name=\"token\" value=\"" . $token . "\"> " . 
     "Select Year: " . 
     "<select name=\"year\" onchange=\"this.form.submit()\">" .
     "<option value=\"" . $year . "\">" . $year . "</option>";
foreach ($years1["Years"] as $v)
{ 
   echo "<option value=\"" . 
   $v .
   "\">" . $v . 
    "</option>";
}
echo " </select>";
echo "</form>";



//GET LIST OF MODELS
$modelsurl = "https://sdc.semadatacoop.org/sdcapi/lookup/models?token=" . $token .
             "&year=" . $year . "&makeid=42";
$modelscontents = file_get_contents($modelsurl);
$models2 = json_decode($modelscontents, true);
//print_r($models2);
//print_r($models2["Models"]);
//print_r($models2["Models"][0]);
echo "<form action=\"index-step3.php\" method=\"post\">" .
     "Select Model: " . 
     "<select name=\"basevid\" onchange=\"this.form.submit()\">";
foreach ($models2["Models"] as $v)
{  
   echo "<option value=\"" .    $v["BaseVehicleID"] .
   "\">" . $v["ModelName"] . " " . $v["ModelID"] . " " . $v["BaseVehicleID"] . 
    "</option>";
}
echo " </select> ";
echo " <input type=\"submit\"/></form>";

?>