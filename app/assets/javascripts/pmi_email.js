
$(function(){
	let copy = document.getElementById('copy-signature')
	let close = document.getElementById('pmi-close')
	
	let sign = document.getElementById('signature')
	sign.addEventListener('contextmenu', notCopy)
	close.addEventListener('click', closeModal)
	copy.addEventListener('click', copyArea)

})

function notCopy(e){
	alert("To copy please use button 'Copy to email'")
	e.preventDefault()
}

function copyArea(e){
	var $temp = $("<input>")
	$("body").append($temp)
	
	$temp.val($("#signature").html()).select()

	var str = `<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
						<html>
						<head>
						</head>
						<body>
						<meta http-equiv="Content-Type" content="text/html charset=UTF-8" />
						${$("#signature").html()}
						</body>
						</html>
						`

	function listener(e) {
		e.clipboardData.setData("text/html", str)
		e.clipboardData.setData("text/plain", str);
		e.preventDefault()
	}
	
  document.addEventListener("copy", listener)
  document.execCommand("copy")
  document.removeEventListener("copy", listener)

  $temp.remove()
	$("#copy-signature").css('background', '#f05924')
	$("#copy-signature").val("Copied - click for instructions")
	
	document.getElementById('copy-signature').removeEventListener('click', copyArea)
	document.getElementById('copy-signature').addEventListener('click', showModal)

}

function showModal(){
		document.getElementById('myModal').style.display = "block"
}

function closeModal(){
	document.getElementById('myModal').style.display = "none"
}