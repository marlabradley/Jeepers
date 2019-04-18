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
$years1 = json_decode($yearscontents, true);
//echo "<br/><br/>Years:"; print_r($years1); print_r($years1["Years"]); echo $years1["Years"][0];
echo "<form action=\"index-step2.php\" method=\"post\">" .
     "<input type=\"hidden\" name=\"token\" value=\"" . $token . "\"> " . 
     "Select Year: " . 
     "<select name=\"year\" onchange=\"this.form.submit()\">" .
     "<option value=\"select a year\">Select a Year</option>";
foreach ($years1["Years"] as $v)
{ 
   echo "<option value=\"" . 
   $v .
   "\">" . $v . 
    "</option>";
}
echo " </select>";
echo "</form>";

?>