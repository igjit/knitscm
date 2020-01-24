USERID = $(shell id -u)

README.md: README.Rmd
	docker-compose run --rm -u $(USERID) r Rscript -e 'rmarkdown::render("README.Rmd", quiet = TRUE)'
