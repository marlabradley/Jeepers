<?php

//GET SDC TOKEN
$tokenurl='https://sdc.semadatacoop.org/sdcapi/token/get?userName=MBradley&password=MBradleySDC!';
$tokenurlcontents = file_get_contents($tokenurl);
$str_arr = preg_split ("/\,/", $tokenurlcontents);
// print_r($str_arr);
$str_arr_token = preg_split ("/\"/", $str_arr[0]);
$str_arr_success = preg_split ("/\"/", $str_arr[1]);
$token = $str_arr_token[3];
if ($str_arr_success[1] != "success") { echo "TOKEN NOT SUCCESSFUL FROM SDC!"; }

//GET LIST OF YEARS AVAILABLE
$yearsurl = "https://sdc.semadatacoop.org/sdcapi/lookup/years?token=" . $token;
$yearscontents = file_get_contents($yearsurl);
//$year = json_decode($yearscontents, true);
echo $yearscontents;
echo "<br/><br/>";

// $yearstr_arr = preg_split ("/\,/", $yearscontents);
// echo $yearstr_arr[0]; echo "<br/><br/>";
// echo $yearstr_arr[1]; echo "<br/><br/>";
// echo $yearstr_arr[2]; echo "<br/><br/>";
// fix this part next
// $firstyear = preg_split ("/\:[/", yearstr_arr[0]);
// print_r($firstyear); echo "first year <br/><br/>";


// Load XML file
$xml = new DOMDocument;
if ($_REQUEST['brand'] == 'Poison Spyder')
   {
      $xml->load('sdc/Poison-Spyder-PIES.xml');
   }
else
   {
        echo "You selected: " . $_REQUEST['brand'];
   }

// Load XSL file
$xsl = new DOMDocument;
$xsl->load('items.xsl');

// Configure the transformer
$proc = new XSLTProcessor();

// Attach the xsl rules
$proc->importStyleSheet($xsl);

echo $proc->transformToXML($xml);










function StrParse($str,$vardata) {
# Then the variables are replaced with the actual variable..
$getvarkeys=array_keys($vardata);
$ret=$str;
for ($x=0; $x < count($getvarkeys); $x++) {
    $myvar=$getvarkeys[$x];
    #echo "Variable: " . $myvar . " [" . $vardata[$myvar] . "]<br>";
    $ret=str_replace('$' . $myvar, $vardata[$myvar], $ret);
}
return $ret;

}


?>