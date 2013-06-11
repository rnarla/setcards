<html>
<body>
<h1> hello world </h1>
</body>
</html>
<script type="text/javascript">
var used_cards

function makeInitialArray() {
	var intial_array = [];
	while (initial_array.length < 12) {
		var random_num = Math.floor(Math.random()*81)
		if (contains(random_num, used_cards)) {
			continue;
		}
		else {
			used_cards.push(random_num);
			initial_array.push(random_num);
		}
	}
	document.write(initial_array)
	return initial_array;
}

function contains(num, array)
	for (int i = 0; i < array.length; i++) {
		if (array[i] == num) {
			return true;
		}
	}
	return false;
}
</script>
