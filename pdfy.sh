#!/bin/bash

# Functions ==============================================

# return 1 if global command line program installed, else 0
# example
# echo "node: $(program_is_installed node)"
function program_is_installed {
  # set to 1 initially
  local return_=1
  # set to 0 if not found
  type $1 >/dev/null 2>&1 || { local return_=0; }
  # return value
  echo "$return_"
}

# display a message in red with a cross by it
# example
# echo echo_fail "No"
function echo_fail {
  # echo first argument in red
  printf "\e[31m✘ ${1}"

  printf "\e[31m Make sure the libraries are installed on your system"

  # reset colours back to normal
  printf "\033\e[0m"

}

# display a message in green with a tick by it
# example
# echo echo_fail "Yes"
function echo_pass {
  # echo first argument in green
  printf "\e[32m✔ ${1}"
  # reset colours back to normal
  printf "\033\e[0m"
}

# echo pass or fail
# example
# echo echo_if 1 "Passed"
# echo echo_if 0 "Failed"
function echo_if {
  if [ $1 == 1 ]; then
    echo_pass $2
  else
    echo_fail $2
  fi
}

# Functions ==============================================

#check if jq and curl has been installed or not
echo "==================================================="
echo "checking curl if   already installed    $(echo_if $(program_is_installed curl))"
echo "==================================================="

###################################################
printf "\e[32m✔ Please type the link of the webpage that you want to get it as PDF:"
read URL_TO_BE_PDF

regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
if [[ $URL_TO_BE_PDF =~ $regex ]]
then 
	printf "\e[32m✔ Generating PDF..... \n"
	CURRENT_DATE_TIME="`date "+%Y-%m-%d %H:%M:%S"`";
	curl --silent -X GET "http://pdfy.net/api/GeneratePDF.aspx?url=$URL_TO_BE_PDF" -o "$CURRENT_DATE_TIME.pdf"

	printf "\e[32m✔ PDF Path: $PWD/$CURRENT_DATE_TIME.pdf \n"
	printf "\033\e[0m"

else
    printf "\e[31m✘ URL is not valid"
    printf "\033\e[0m"
    exit 0;
fi
