
$(function(){
	let copy = document.getElementById('copy-signature')
	copy.addEventListener('click', copyArea)
})


function copyArea(e){
	e.preventDefault()
	debugger
	document.getElementById('signature').select()
	document.execCommand('copy')
}
