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
		delimiter: ',',
		removeWithBackspace: true,
		'autocomplete': {
			source: ["Project Manager","Project Coordinator","Project Control Officer","Project Analyst","Investment Analyst","Analyst","Research","Product Manager"]
		},
		confirmKeys: [13, 9, 44]
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
			getJobs()
			resetModal()
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
	fetch(`/users/${userId}/requests`,{
		method: 'post',
		credentials: 'same-origin',
    headers: {'Content-Type': 'application/json'},
		body: JSON.stringify(data)
	}).then(response => response.json())
	.then(function(data){
		request = new Request(data.id, data.date_updated, data.job_count, data.job_titles, data.excludes, data.includes)
		makeCard(request)
		document.getElementById(`update-request-${request.id}`).click()
	})
}

function resetModal() {
	$('#createRequest').modal('hide')
}