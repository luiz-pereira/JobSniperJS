* move scrape to services - OK

* fix oauth - nothing to fix(?)

* new/edit request
- Fix the job_titles once again. i.e. create join table job_titles_request. OK
- try to implement a suggestion for - jobtitles. OK
- include as many job titles as you want. OK
- one nice way to includes and excludes, with one text_field two buttons. OK - even better

* list requests
- show it nicely (kind of nice)
- maybe allow for editing in loco?
- grab through API
- show titles has_many
- show number of jobs has_many

* list jobs (show page request)
- show page
- show it nicely

* update request
- try to do it asynchronous (with current status). through rails api and then?. method update() in JS class Request.

* write some tests

* pmi emails
- change it to a one page application with JS



display: inline-block;
  top: 0px;
  position: relative;
	width: 262px;
	max-height: 230px;
  background-color: #ffffff;
  border-radius: 4px;
  padding: 32px 24px;
  margin: 12px;
  text-decoration: none;
  overflow: hidden;
  border: 1px solid #cccccc;