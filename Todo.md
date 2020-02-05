* move scrape to services - OK

* fix oauth - nothing to fix(?)

* new/edit request
- Fix the job_titles once again. i.e. create join table job_titles_request. OK
- try to implement a suggestion for - jobtitles. OK
- include as many job titles as you want. OK
- one nice way to includes and excludes, with one text_field two buttons. OK - even better

* list requests
- maybe allow for editing in loco?
- show it nicely (kind of nice)
- grab through API - OK
- show titles has_many - OK
- show number of jobs has_many - OK

* list jobs (show page request)
- show page
- show it nicely - meh - OK

* update request
- try to do it asynchronous (with current status). through rails api and then?. method update() in JS - OK

* write some tests




* pmi emails
- change it to a one page application with JS

class Request. - OK - check if it is updating the text for job_counting


- clicar modal
- 'make request'
	- manda 'post' para a API, que vai executar o scrape OK
		- scrape precisa ser temporario, sem criar request OK
	- salva os jobs do scrape temporariamente na tabela jobs, marca como temporario (request_id nil?)

	- enquanto scrapa, disabla tudo, pois user precisa esperar -
	- Deleta o request
	- Job search esta case sensitive!!!!!
	- Permitir request sem job title
	- Permitir request sem include (mas com job title / somente para signed)
	- job title box sucks
	- cards sucks
	- deploy new version
	

