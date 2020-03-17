let requests = []
let userId = ''

$(function(){
	userId = $('#user_id').val()
	getRequests()
	handleCreateRequest()
})

function getRequests(){

	fetch(`/users/${userId}/data/requests`)
	.then(response => response.json())
	.then(function(data){
		createRequests(data)
		makeCards()
	})
}

function makeCards(){
	$('#request-cards').empty()
	requests.forEach(request => makeCard(request))
}

async function getRequest(request){
	let response = fetch(`/users/${userId}/data/requests/${request.id}`).then(response => response.json())
	return await response
}

function createRequests(data){
	$(data).each(function(){
		new Request(this.id, this.date_updated, this.job_count, this.job_titles, this.excludes, this.includes, this.locations)
	})
}

class Request{
	constructor(id, dateUpdated, jobCount, titles, excludes, includes, locations){
		this.id = id
		this.dateUpdated = dateUpdated
		this.jobCount = jobCount
		this.titles = titles
		this.excludes = excludes
		this.includes = includes
		this.locations = locations

		requests.push(this)
	}
	async update(){
		let response = getRequest(this)
		response.then(data => {
			this.jobCount = data.job_count
			this.dateUpdated = data.date_updated
			this.titles = data.job_titles
			this.excludes = data.excludes
			this.includes = data.includes
			this.locations = data.locations 
		})
		return await response
	}
}

function makeCard(request){
	let excludes = ""
	request.excludes.forEach(exclude => excludes += `<p class='excludes'>- ${exclude}</p></li>`)
	let includes = ""
	request.includes.forEach(include => includes += `<p class='includes'>+${include}</p></li>`)
	let titles = request.titles.join(', ')
	let jobCount = request.jobCount

	let card = `
			<div class="card4">
				<div class="card4-inner">
					<div class="card4-front">
						<h5 id="request-titles">${titles}</h5>
						<div class="row">
							<ul class="col">
								${includes}
							</ul>
							<ul class="col">
								${excludes}
							</ul>
						</div>
						<h7 class="update-status" id='update-status-${request.id}'>Updated on ${request.dateUpdated}</h7>
					</div>

					<div class="card4-back">
						<div class="row">
							<div class="col-md-12">
								<svg height="35" viewBox="0 0 64 64" width="35" xmlns="http://www.w3.org/2000/svg"><path d="m61 57v3a1 1 0 0 1 -1 1h-56a1 1 0 0 1 -1-1v-3z" fill="#bddbff"/><path d="m54.68 49.92a1 1 0 0 0 1.41 0l.91-.91 4 7.99h-21l-2-4h-12l-2 4h-21l6-12h40.76z" fill="#bddbff"/><path d="m58.92 45.68-3.92-3.92-2.44-2.44-4.24 4.24 1.44 1.44 4.92 4.92a1 1 0 0 0 1.41 0l.91-.91 1.92-1.92a1 1 0 0 0 0-1.41z" fill="#bddbff"/><path d="m49.02 37.19-2.02-2.02-.93-.93-.01-.01a10.583 10.583 0 0 1 -2.83 2.83l.01.01 1.92 1.92 1.03 1.03.01.01 2.83-2.83z" fill="#bddbff"/><path d="m42 11a1 1 0 0 1 -1-1v-7h-22a2.006 2.006 0 0 0 -2 2v32a2.006 2.006 0 0 0 2 2h18a11.006 11.006 0 1 1 10-15.58v-12.42z" fill="#bddbff"/><g fill="#3d9ae2"><path d="m61.894 56.552-3.676-7.343 1.409-1.41a2 2 0 0 0 0-2.828l-3.627-3.628v-28.343a3 3 0 0 0 -3-3h-5.5l-5.7-7.6a1 1 0 0 0 -.8-.4h-22a3 3 0 0 0 -3 3v5h-5a3 3 0 0 0 -3 3v31.764l-5.895 11.789a1 1 0 0 0 -.105.447v3a2 2 0 0 0 2 2h56a2 2 0 0 0 2-2v-3a1 1 0 0 0 -.106-.448zm-21.276-.552-1.718-3.447a1 1 0 0 0 -.9-.553h-12a1 1 0 0 0 -.895.553l-1.723 3.447h-18.764l5-10h39.725l4.628 4.627a1.989 1.989 0 0 0 2.752.063l2.658 5.31zm-2.236 0h-12.764l1-2h10.764zm-8.453-20.929a10 10 0 1 1 14.142 0 10.011 10.011 0 0 1 -14.142 0zm12.071-29.071 3 4h-3zm3.485 30.485c.239-.238.457-.489.672-.743l1.45 1.45-1.415 1.415-1.45-1.45c.258-.215.505-.433.743-.672zm4.243 1.415 1.414 1.414-2.829 2.829-1.413-1.415zm5.657 11.314-5.657-5.657 2.828-2.829 5.658 5.657zm-1.385-36.214v26.343l-3.565-3.565a1 1 0 0 0 -1.414 0l-1.694-1.693a12.035 12.035 0 0 0 .673-10.855v-11.23h5a1 1 0 0 1 1 1zm-36-8a1 1 0 0 1 1-1h21v6a2 2 0 0 0 2 2h4v8.084c-.169-.191-.332-.386-.515-.569a12 12 0 1 0 -15.118 18.485h-11.367a1 1 0 0 1 -1-1zm-8 8a1 1 0 0 1 1-1h5v25a3 3 0 0 0 3 3h18v-.006a12 12 0 0 0 6.085-1.667l1.693 1.694a1 1 0 0 0 0 1.414l2.565 2.565h-37.343zm-6 47v-2h56v2z"/><path d="m10 52h2v2h-2z"/><path d="m14 52h2v2h-2z"/><path d="m48 52h2v2h-2z"/><path d="m52 52h2v2h-2z"/><path d="m15 48h2v2h-2z"/><path d="m11 48h2v2h-2z"/><path d="m19 48h2v2h-2z"/><path d="m23 48h2v2h-2z"/><path d="m27 48h2v2h-2z"/><path d="m31 48h2v2h-2z"/><path d="m35 48h2v2h-2z"/><path d="m39 48h2v2h-2z"/><path d="m43 48h2v2h-2z"/><path d="m47 48h2v2h-2z"/><path d="m18 52h4v2h-4z"/><path d="m42 52h4v2h-4z"/><path d="m42.657 22.343a8 8 0 1 0 2.343 5.657 7.948 7.948 0 0 0 -2.343-5.657zm-1.414 9.9a6 6 0 1 1 1.757-4.243 5.963 5.963 0 0 1 -1.757 4.243z"/><path d="m22 11h8v2h-8z"/><path d="m22 8h4v2h-4z"/><path d="m28 8h2v2h-2z"/><path d="m22 16h6v2h-6z"/><path d="m22 20h2v2h-2z"/></g></svg>
								<a href="/users/${userId}/requests/${request.id}/jobs"><p class="text-center job-count" id="job-count-${request.id}">${jobCount} Jobs</p></a>
							</div>
						</div>
						<div class="text-center buttons">
							<button class="btn btn-primary" id="update-request-${request.id}">Update</button>
						</div>
						<div class="text-center buttons">
							<button class="btn btn-warning" id="edit-request-${request.id}">Edit</button>
							<button class="btn btn-danger" id="delete-request-${request.id}">Delete</button>
						</div>
					</div>
				</div>
			</div>
		`
	$('#request-cards').append(card)
	// update button
	document.getElementById(`update-request-${request.id}`).addEventListener("click", function(e){
		requestUpdate(request).then(() => {
			request.update().then(() => {
				$(`#update-status-${request.id}`).text("Updated!");
				$(`#update-status-${request.id}`).css('color', 'green');
				$(`#job-count-${request.id}`).text(`${request.jobCount} Jobs`)
			})
		})
	})
	// delete button
	document.getElementById(`delete-request-${request.id}`).addEventListener("click", function(e){
		requestDelete(request).then(() => {
			requests = requests.filter(r => r.id !== request.id)
			makeCards()
		})
	})
}

async function requestUpdate(request){
	response = fetch(`/users/${userId}/requests/${request.id}/jobs`,{
		method: 'PATCH',
		body: {"id": `"${request.id}"`}
	})
	$(`#update-status-${request.id}`).text("Updating...")
	$(`#update-status-${request.id}`).css('color', 'red')
	return await response
}

async function requestDelete(request){
	response = fetch(`/users/${userId}/requests/${request.id}`,{
		method: 'DELETE'
	})
	return await response
}

function handleCreateRequest(){
	$('#newRequestjobTitles').tagsInput({
		interactive: true,
		placeholder: 'Please input the job titles',
		width: 'auto',
		height: 'auto',
		hide: true,
		// searchOnFocus: true, 
		delimiter: ',',
		removeWithBackspace: true
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

	$('#locations').tagsInput({
		interactive: true,
		placeholder: 'Locations to be included',
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
			postAndCreateRequest()
			resetModal()
		}
	})
}

function postAndCreateRequest(){
	let jobTitles = $('#newRequestjobTitles').val()
	let excludes = $('#excludes').val()
	let includes = $('#includes').val()
	let locations = $('#locations').val()
	let data = {
		job_titles: jobTitles,
		excludes: excludes,
		includes: includes,
		locations: locations
	}
	fetch(`/users/${userId}/requests`,{
		method: 'post',
		credentials: 'same-origin',
    headers: {'Content-Type': 'application/json'},
		body: JSON.stringify(data)
	}).then(response => response.json())
	.then(function(data){
		request = new Request(data.id, data.date_updated, data.job_count, data.job_titles, data.excludes, data.includes, data.locations)
		makeCard(request)
		document.getElementById(`update-request-${request.id}`).click()
	})
}

function resetModal() {
	$('#createRequest').modal('hide')
}