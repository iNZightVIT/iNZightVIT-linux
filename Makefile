PROFILE := .Rprofile
INZIGHT := inzight
VIT     := vit
DIR     := $(shell pwd)
RCMD    := R
CRAN    := https://cran.rstudio.com
CPUS    := $(shell getconf _NPROCESSORS_ONLN)

default: $(PROFILE) $(INZIGHT) $(VIT)
	@mkdir -p library
	@$(RCMD) --slave -e "install.packages(c('vit'), dependencies = TRUE, Ncpus = $(CPUS))" --args install
	# @$(RCMD) --slave -e "install.packages(c('iNZightRegression', 'iNZightPlots', 'iNZightTS', 'iNZightMR', 'vit', 'iNZightTools', 'FutureLearnData', 'iNZightModules', 'iNZight'), dependencies = TRUE, Ncpus = $(CPUS))"

$(PROFILE):
	@cp Rprofile.template $@
	@sed -i 's|LIB_PATH|$(DIR)|' $@
	@sed -i 's|CRAN|$(CRAN)|' $@
	@mkdir -p .clean && mv Rprofile.template .clean

$(INZIGHT):
	@cp inzight.tmp $@
	@sed -i 's|INSTALL_DIR|$(DIR)|' $@
	@chmod +x $@
	@mkdir -p .clean && mv inzight.tmp .clean

$(VIT):
	@cp vit.tmp $@
	@sed -i 's|INSTALL_DIR|$(DIR)|' $@
	@chmod +x $@
	@mkdir -p .clean && mv vit.tmp .clean

clean:
	# @rm -rf library
	@rm .Rprofile inzight vit
	@mv .clean/* ./ && rm -rf .clean
