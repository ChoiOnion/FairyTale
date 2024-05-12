<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Typing</title>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />
<link rel="stylesheet" href="style2.css" />
</head>

<body>
	<div class="container">
		<div class="stats">
			<p>Time: <span id="timer">0s</span></p>
			<p>Mistakes: <span id="mistakes">0</span></p>
		</div>
		<div id="quote"></div>
		<textarea rows="5" id="quote-input" placeholder="Type here when the test starts.."></textarea>

		<div class="result">
			<h3>Result</h3>
			<div class="wrapper">
				<p>Accuracy: <span id="accuracy"></span></p>
				<p>Speed: <span id="wpm"></span></p>
			</div>
		</div>
	</div>
</body>
</html>