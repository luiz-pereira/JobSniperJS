
$(function(){
	let copy = document.getElementById('copy-signature')
	copy.addEventListener('click', copyArea)
})


function copyArea(e){
	var $temp = $("<input>")
	$("body").append($temp)
	
	$temp.val($("#signature").html()).select()

	var str = $("#signature").html()

	function listener(e) {
		e.clipboardData.setData("text/html", str)
		e.clipboardData.setData("text/plain", str);
		e.preventDefault()
	}
	
  document.addEventListener("copy", listener)
  document.execCommand("copy")
  document.removeEventListener("copy", listener)

  $temp.remove()
	$("#copy-signature").css('background', 'linear-gradient(45deg, #d5135a, #f05924)')
	$("#copy-signature").val("copied!")
}

