const jobs = []
let userId = ""
let requestId = ""
let temporary = false

$(function(){
	userId = $('#user-id').val()
	requestId = $('#request-id').val()
	temporary = $('#temporary').val()
	getJobs().then(function(data){
		createJobs(data)
		makeTable()
		// delete the temporary request
		if (temporary === 'true'){
			fetch(`/requests/${requestId}`,{
				method: 'DELETE'
			})
		}
	})
})

async function getJobs(){
	let response = fetch(`/users/${userId}/data/requests/${requestId}/jobs`).then(response => response.json())
	return await response
}

function createJobs(data){

	data.forEach(job =>{
		new Job(job.id, job.source, job.title, job.company, job.tipe, job.city, job.summary, job.description, job.link)
	})
}

class Job {
	constructor(id, source, title, company, type, city, summary, description, link){
		this.id = id
		this.source = source
		this.title = title
		this.company = company
		this.type = type
		this.city = city
		this.summary = summary
		this.description = description
		this.link = link
		jobs.push(this)
	}
}

function makeTable(){
	var jobsRow = ""
	jobs.forEach(job => {
		jobsRow = ''
		jobsRow +=`
				<tr>
					<td>${job.source}</td>
					<td>${job.title}</td>
					<td>${job.company}</td>
					<td>${job.type}</td>
					<td>${job.city}</td>
					<td id="job-description-td-${job.id}">${job.summary}<button class="job-summary" id="job-summary-${job.id}">...more</button><button style="visibility:hidden" class="job-summary" id="job-description-${job.id}">less</button></td>
					<td><a href="${job.link}" target="_blank">Link to the position</a></td>
				</tr>`
				$('#table-jobs').append(jobsRow)
				document.getElementById(`job-summary-${job.id}`).addEventListener('click', function(e){
					e.preventDefault()
					$(`#job-description-td-${job.id}`).contents()[0].textContent = job.description
					document.getElementById(`job-summary-${job.id}`).style.visibility = 'hidden'
					document.getElementById(`job-description-${job.id}`).style.visibility = 'visible'
				})
				document.getElementById(`job-description-${job.id}`).addEventListener('click', function(e){
					e.preventDefault()
					$(`#job-description-td-${job.id}`).contents()[0].textContent = job.summary
					document.getElementById(`job-summary-${job.id}`).style.visibility = 'visible'
					document.getElementById(`job-description-${job.id}`).style.visibility = 'hidden'
				})
	});
}

function changeTextdescription(){

}