<?php $link = mysql_connect('localhost', 'root'); ?>
<html>
<head>
	<title>Hi there, this is php "Hello World" page by Liz!</title>
	<style>
	body {
		background-color: white;
		text-align: center;
		padding: 50px;
		font-family: "Open Sans","Helvetica Neue",Helvetica,Arial,sans-serif;
	}
	#logo {
		margin-bottom: 40px;
	}
	</style>
</head>
<body>
<h1>
<?php
echo 'Hi there, this is php "Hello World" page by Liz!';
?>
</h1>
<?php if(!$link) { ?>
    <h2>Cant connect to local MySQL Server!</h2>
<?php } else { ?>
<h2>MySQL Server version: <?php echo mysql_get_server_info(); echo " x-x " ?></h2>
<?php } ?>

<?php
// /var/www/html/index.php - Read MySQL from PHP

// MySQL Login
$user='busman';
$password='southparks2e17';

// Data Source Name i.e. connection details
$database='busplan';
$dsn="mysql:host=localhost;charset=UTF8;dbname=$database";

// Open Connection, create new object of PDO class
$pdo=new PDO($dsn, $user, $password);

// Perform SQL Query
$pdoStatement=$pdo->prepare('SELECT * FROM plans;');
$pdoStatement->execute();
$hits=$pdoStatement->fetchAll();

// Print the $hits Array
foreach($hits as $row) {
 echo "<p>".$row['id']." ".$row['name']."</p>\n";
}
?>
</body>
</html>
