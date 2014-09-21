## Utility function:
## =================

# Get the PATH of the current file
get.filepath <- function() {
  # The following code has been borrowed by the following Stackoverflow
  # reply: http://stackoverflow.com/a/1816487
  frame_files <- lapply(sys.frames(), function(x) x$ofile)
  frame_files <- Filter(Negate(is.null), frame_files)
  path <- dirname(frame_files[[length(frame_files)]])
  path  # Return the path
}
