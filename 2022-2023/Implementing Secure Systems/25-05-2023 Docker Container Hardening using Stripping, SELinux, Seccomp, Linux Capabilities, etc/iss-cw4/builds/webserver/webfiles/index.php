<?php
$servername = "db.iss.cyber23.test";
$fullname = "wwwissclient2023";
$password = "wwwissclient2023Creds";
$dbname = "iss2023db";

// Create connection
$conn = new mysqli($servername, $fullname, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$stmt = $conn->prepare("SELECT fullname,suggestion FROM suggestion");
$stmt->execute();
$stmt->store_result();

$HTML = <<<THEEND
<!DOCTYPE html>
<html>
<head>
<title>ISS CW4 - Feedback</title>
</head>
<body>
<h3>Please provide constructive suggestion(s)</h3>
<form action="action.php" method="post">
  Username<br>
  <input type="text" name="fullname" value="">
  <br>
  suggestion<br>
  <input type="text" name="suggestion" value="">
  <br><br>
  <input type="submit" value="Submit">
</form> 

<p>Use the "Submit" button above to put your suggestion in the guest book.</p>
<table style="border:1px solid black">
<tr>
<th>Name</th>
<th>Suggestion</th>
</tr>
THEEND;
print $HTML;

$stmt->bind_result($cuser,$csuggestion);
while ($stmt->fetch()) {
	print "<tr>";
	print "<td>";
	print $cuser;
	print "</td>";
	print "<td>";
	print $csuggestion;
	print "</td>";
	print "</tr>";
}
$HTML = <<<THEEND
</table>
</body>
</html>
THEEND;
print $HTML;

$stmt->close();
$conn->close();


?>
