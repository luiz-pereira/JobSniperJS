$(function(){
	handleCreateRequest()
})

function handleCreateRequest(){
	
	$('#newRequestjobTitles').tagsInput({
		interactive: true,
		placeholder: 'Please input the job titles',
		width: 'auto',
		height: 'auto',
		hide: true,
		// searchOnFocus: true, 
		delimiter: ',',
		removeWithBackspace: true,
		// autocomplete: {
		// 	source: ["Project Manager","Project Coordinator","Project Control Officer","Project Analyst","Investment Analyst","Analyst","Research","Product Manager"]
		// },
	});

	$('#includes').tagsInput({
		interactive: true,
		placeholder: 'Terms to be included in your search',
		width: 'auto',
		height: 'auto',
		hide: true,
		delimiter: ',',
		removeWithBackspace: true,
	});

	$('#excludes').tagsInput({
		interactive: true,
		placeholder: 'Terms to be excluded from your search',
		width: 'auto',
		height: 'auto',
		hide: true,
		delimiter: ',',
		removeWithBackspace: true,
	});
	
	$('#make-request').on('click', function(event){

		if ($('#job_titles_tagsinput').text() === "" && $('#excludes_tagsinput').text() === "" &&$('#includes_tagsinput').text() === ""){
			event.preventDefault()
			$('#bottom').empty()
			$('#bottom').append('<div id="alert-bottom" class="alert alert-danger" role="alert">You need to fill at least one the fields or it will take too long!</div>')
		} else {
			event.preventDefault()
			document.getElementById('newRequestjobTitles_tag').disabled = true
			document.getElementById('includes_tag').disabled = true
			document.getElementById('excludes_tag').disabled = true
			document.getElementsByClassName('tag-text').disabled = true
			document.getElementById('make-request').disabled = true
			document.getElementById('modal-close').disabled = true
			document.getElementById('make-request').value = "Searching..."
			try{
				getJobs()
			}
			catch(err){
				alert(err)
				window.location.reload()
			}

		}	
	})
}

function getJobs(){
	let jobTitles = $('#newRequestjobTitles').val()
	
	let excludes = $('#excludes').val()
	let includes = $('#includes').val()
	let data = {
		job_titles: jobTitles,
		excludes: excludes,
		includes: includes,
		temporary: true
	}
	fetch(`/requests/temp/`,{
		method: 'post',
		credentials: 'same-origin',
    headers: {'Content-Type': 'application/json'},
		body: JSON.stringify(data)
	}).then(response => response.json())
	.then(function(data){
		window.location = (`/requests/${data.id}/jobs`)
	})

}

function resetModal() {
	$('#createRequest').modal('hide')
}