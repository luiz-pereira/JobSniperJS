$(document).ready(function(){
	$('#job_titles').tagsInput({
		interactive: true,
		placeholder: 'Please input the job titles',
		width: 'auto',
		height: 'auto',
		hide: true,
		delimiter: ',',
		removeWithBackspace: true,
		'autocomplete': {
			source: ["Project Manager","Project Coordinator","Project Control Officer","Project Analyst","Investment Analyst","Analyst","Research","Product Manager"]
		 }
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
			$('#bottom').append('<div id="alert-bottom" class="alert alert-danger" role="alert">You need to fill at least one the fields or it will take too long!</div>')
		} else {
			$('#bottom').empty()
			$(this).submit()
		}
	})

});