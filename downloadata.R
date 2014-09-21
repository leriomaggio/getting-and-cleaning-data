## Usage: 
## ======
# Source the file and invoke the download.data() function

source("utility.R")

download.data <- function () {
  # Dowload the UCI HAR Dataset and store it into a `dataset.zip` file 
  # located into the `dataset` folder.
  
  # Get Current WD
  current.wd <- get.filepath()
  dataset.folder <- file.path(current.wd, 'dataset')
  
  if (!file.exists(dataset.folder)){
    dir.create(dataset.folder)
  }
  
  zip.url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
  zip.file <- file.path(dataset.folder, 'dataset.zip')
  
  # NOTE: please remove `method = 'curl' if you're not running this 
  # script on a Mac OSX machine
  download.file(zip.url, destfile=zip.file, method='curl')
  unzip(zip.file, exdir=current.wd)
}

# -----
# Main:
# -----

# Invoke the download.data script
download.data()
